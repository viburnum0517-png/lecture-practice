#!/usr/bin/env python3
"""Gemini API Image Generation - Connectivity Test

Nano Banana 2 (gemini-3.1-flash-image-preview) API 연결 테스트.
실제 이미지 생성 없이 API 키 유효성 + 모델 접근 가능 여부만 확인.

Usage:
    python3 gemini-api-test.py                        # 기본 테스트
    python3 gemini-api-test.py --generate              # 실제 이미지 1장 생성 (비용 발생)
    python3 gemini-api-test.py --generate --size 2K    # 2K 해상도로 생성
    GEMINI_API_KEY=xxx python3 gemini-api-test.py      # 환경변수로 키 전달
"""

import argparse
import os
import sys
import time
import base64
from pathlib import Path

# ─── Config ───────────────────────────────────────────────────────
API_KEY = os.environ.get("GEMINI_API_KEY", "AIzaSyDl749zbNCyGWJudvuy86A_WQuGSMu6_7E")
MODEL_ID = "gemini-3.1-flash-image-preview"  # Nano Banana 2

# 슬라이드 덱용 기본 설정
DEFAULT_CONFIG = {
    "aspect_ratio": "16:9",
    "image_size": "1K",         # 512, 1K, 2K, 4K
    "thinking_level": "minimal", # minimal, high
    "google_search": False,
}

# 해상도별 단가 (USD)
PRICING = {
    "512": 0.045,
    "1K": 0.067,
    "2K": 0.101,
    "4K": 0.151,
}


def test_connectivity():
    """API 키 유효성 + 모델 접근 테스트 (이미지 생성 없음)"""
    from google import genai
    from google.genai import types

    print(f"{'='*60}")
    print(f"Gemini API Connectivity Test")
    print(f"{'='*60}")
    print(f"Model: {MODEL_ID} (Nano Banana 2)")
    print(f"API Key: {API_KEY[:10]}...{API_KEY[-4:]}")
    print()

    # Step 1: 클라이언트 초기화
    print("[1/3] Initializing client...", end=" ")
    try:
        client = genai.Client(api_key=API_KEY)
        print("OK")
    except Exception as e:
        print(f"FAIL\n  Error: {e}")
        return False

    # Step 2: 모델 접근 테스트 (간단한 텍스트 생성)
    print("[2/3] Testing model access (text-only)...", end=" ")
    try:
        t0 = time.time()
        response = client.models.generate_content(
            model=MODEL_ID,
            contents="Reply with exactly: CONNECTION_OK",
            config=types.GenerateContentConfig(
                response_modalities=["TEXT"],
            )
        )
        elapsed = time.time() - t0
        text = response.text.strip() if response.text else "(empty)"
        print(f"OK ({elapsed:.1f}s)")
        print(f"  Response: {text}")
    except Exception as e:
        print(f"FAIL\n  Error: {e}")
        return False

    # Step 3: 이미지 생성 설정 검증 (생성하지 않음, config만 구성)
    print("[3/3] Validating image config...", end=" ")
    try:
        config = types.GenerateContentConfig(
            response_modalities=["TEXT", "IMAGE"],
            image_config=types.ImageConfig(
                aspect_ratio=DEFAULT_CONFIG["aspect_ratio"],
                image_size=DEFAULT_CONFIG["image_size"],
            ),
        )
        print("OK")
        print(f"  Aspect Ratio: {DEFAULT_CONFIG['aspect_ratio']}")
        print(f"  Image Size: {DEFAULT_CONFIG['image_size']}")
        print(f"  Thinking: {DEFAULT_CONFIG['thinking_level']}")
        print(f"  Google Search: {'on' if DEFAULT_CONFIG['google_search'] else 'off'}")
    except Exception as e:
        print(f"FAIL\n  Error: {e}")
        return False

    # 비용 추정
    print()
    print(f"{'='*60}")
    print("Cost Estimation (Slide Deck)")
    print(f"{'='*60}")
    for size, price in PRICING.items():
        print(f"  {size:>4s}: ${price:.3f}/img  |  10장=${price*10:.2f}  |  20장=${price*20:.2f}")
    print()
    current_price = PRICING[DEFAULT_CONFIG["image_size"]]
    print(f"  Current setting ({DEFAULT_CONFIG['image_size']}): ${current_price:.3f}/image")
    print()
    print("All tests passed. Ready for image generation.")
    return True


def generate_test_image(image_size="1K", output_dir=None):
    """테스트 이미지 1장 생성 (비용 발생)"""
    from google import genai
    from google.genai import types

    if output_dir is None:
        output_dir = Path(__file__).parent.parent / "test-output"
    else:
        output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    client = genai.Client(api_key=API_KEY)

    test_prompt = (
        "A professional slide cover image for a tech presentation. "
        "Clean modern design with subtle geometric patterns. "
        "Dark blue gradient background with white accent lines. "
        "Large bold text reads 'API TEST'. "
        "Minimalist, corporate style. No people."
    )

    print(f"Generating test image...")
    print(f"  Model: {MODEL_ID}")
    print(f"  Size: {image_size}")
    print(f"  Ratio: 16:9")
    print(f"  Est. cost: ${PRICING[image_size]:.3f}")
    print()

    t0 = time.time()
    response = client.models.generate_content(
        model=MODEL_ID,
        contents=test_prompt,
        config=types.GenerateContentConfig(
            response_modalities=["TEXT", "IMAGE"],
            image_config=types.ImageConfig(
                aspect_ratio="16:9",
                image_size=image_size,
            ),
        )
    )
    elapsed = time.time() - t0

    saved = False
    for part in response.parts:
        if part.text:
            print(f"  Text: {part.text[:200]}")
        elif hasattr(part, 'inline_data') and part.inline_data:
            out_path = output_dir / f"test-{image_size}.png"
            img_data = base64.b64decode(part.inline_data.data)
            out_path.write_bytes(img_data)
            print(f"  Saved: {out_path} ({len(img_data)/1024:.0f} KB)")
            saved = True
        else:
            # Try as_image() method
            try:
                img = part.as_image()
                if img:
                    out_path = output_dir / f"test-{image_size}.png"
                    img.save(str(out_path))
                    print(f"  Saved: {out_path}")
                    saved = True
            except Exception:
                pass

    print(f"  Time: {elapsed:.1f}s")
    print(f"  Cost: ~${PRICING[image_size]:.3f}")

    if not saved:
        print("  WARNING: No image data in response")
        print(f"  Raw parts: {[type(p).__name__ for p in response.parts]}")

    return saved


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Gemini API Image Generation Test")
    parser.add_argument("--generate", action="store_true", help="Actually generate a test image (costs money)")
    parser.add_argument("--size", default="1K", choices=["512", "1K", "2K", "4K"], help="Image size for generation")
    parser.add_argument("--output", default=None, help="Output directory")
    args = parser.parse_args()

    if args.generate:
        generate_test_image(image_size=args.size, output_dir=args.output)
    else:
        success = test_connectivity()
        sys.exit(0 if success else 1)
