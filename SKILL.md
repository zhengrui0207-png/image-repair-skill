---
name: image-repair-studio
description: Operate, test, and maintain the cloud selected-region image repair studio for batch image import, rectangle fill, local smart removal, AI inpainting with Seedream or OpenAI-compatible models, cropping, resizing, and export. Use this skill whenever the user asks to repair or remove an authorized unwanted region from images, process many images with a fixed selection, configure an image-editing API, troubleshoot unchanged AI results, export cropped/resized images, or deploy/update the image repair service.
compatibility: Browser access is required for interactive editing. Deployment requires Node.js, npm, SSH, and access to the target server.
---

# Image Repair Studio

Use the hosted studio at `http://8.141.101.70/image-repair/` for interactive work. Only process images the user owns or is authorized to edit.

## Choose the workflow

- For one or more user images, open the hosted studio and use the browser workflow below.
- For a health check, run `scripts/check_service.sh`.
- For API configuration or debugging, read `references/model-configuration.md`.
- For deployment or code changes, use the standalone image repair source checkout and follow the deployment workflow below.

## Browser workflow

1. Open `http://8.141.101.70/image-repair/`.
2. Import one or more PNG, JPG, WebP, BMP, GIF, TIFF, or AVIF images.
3. Drag on the image to create the repair selection. Keep the selection slightly larger than the unwanted object.
4. Choose the processing mode:
   - `矩形覆盖`: Use for flat backgrounds and fixed-color overlays.
   - `本地智能消除`: Use for text, small objects, gradients, and simple textures without an API.
   - `AI 修复`: Use for complex textures, people, objects, shadows, or perspective.
5. For repeated layouts, save the current selection as a template and process the queue in a batch.
6. Review the original/result comparison before export.
7. Set full-image or selection crop, original or custom dimensions, and PNG/JPG/WebP output.
8. Download one result from the preview or use `批量下载` to package every completed result into a ZIP. Remove unfinished queue items with the `×` button when needed.

## AI repair rules

- Prefer the default Seedream configuration unless the user explicitly supplies another compatible model.
- Never request or expose a user's API key in chat. Let the user enter it in the password field.
- The model receives a crop around the selection plus a marked guide image.
- The returned model image must be composited only inside the selected rectangle. Pixels outside the selection must remain unchanged.
- If the result is visually unchanged, verify selection alignment, prompt clarity, model editing support, API endpoint, and response image parsing before retrying.

## Deployment workflow

The current production service is isolated from the AI career advisor:

- Public path: `/image-repair/`
- Internal port: `3101`
- PM2 process: `image-repair-studio`
- Remote directory: `/var/www/image-repair-studio`

When the source checkout contains `scripts/deploy-ecs.sh`:

1. Run the image-mode production build locally.
2. Run `npm run deploy:image-repair` from the project root.
3. Verify the image repair URL returns HTTP 200.
4. Verify the root URL still returns HTTP 200.
5. Verify `image-repair-studio` is online in PM2 and Nginx configuration remains valid.
6. Do not overwrite remote `.env`, databases, uploads, or unrelated PM2 processes.

## Verification checklist

- The page loads without console errors.
- Upload and drag selection work for portrait and landscape images.
- Unfinished queue items can be removed individually; completed items retain their result.
- Original/result previews render.
- AI test output changes the selected area and leaves all outside pixels identical.
- Crop and custom-size export produce the requested pixel dimensions and file format.
- Batch download produces a valid ZIP containing every completed result and skips unfinished items.
- `http://8.141.101.70/` remains available after deployment.

## Final report

Report only the high-signal outcome:

- What was processed or changed.
- Which mode/model was used.
- Export format and dimensions when relevant.
- Production URL and verification status after deployment.
- Any limitation, especially when a real model call could not be tested without the user's locally entered key.
