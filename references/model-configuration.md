# Model Configuration

## Seedream default

- Provider: `seedream`
- Base URL: `https://ark.cn-beijing.volces.com/api/v3`
- Model ID: `doubao-seedream-4-0-250828`
- Endpoint: `/images/generations`

Seedream receives two images: the source crop and a guide crop with a magenta rectangle. The prompt must explicitly identify image 1 as the source and image 2 as the location guide, remove or reconstruct the marked content, and preserve everything outside that area.

## OpenAI-compatible editing

Use an API that supports an image editing endpoint compatible with `/images/edits`.

Required fields:

- `base_url`
- `model_id`
- `api_key`
- An edit-capable image model

The request uses multipart form data first and JSON as a compatibility fallback. The mask is opaque outside the selection and transparent inside it.

## Troubleshooting unchanged results

1. Confirm the selected rectangle maps to the displayed image rather than the surrounding preview container.
2. Confirm the model supports image editing, not only text-to-image generation.
3. Confirm Seedream receives both the source crop and magenta guide crop.
4. Use an explicit action prompt such as removing the selected object and reconstructing the natural background.
5. Confirm the response parser reads `b64_json`, `image_base64`, `url`, or `image_url`.
6. Composite the generated crop only inside the original selection.
7. Compare pixels inside and outside the selection. Outside difference must be zero.

## Secret handling

Do not commit API keys, place them in URLs, print them in logs, or ask the user to paste them into chat. Keep keys in the interactive password field or a protected server environment variable.
