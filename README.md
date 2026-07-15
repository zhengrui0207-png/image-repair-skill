# Image Repair Studio Skill

Codex Skill for operating, testing, and maintaining the selected-region image repair studio hosted at:

`http://8.141.101.70/image-repair/`

## Capabilities

- Batch image import and fixed-region templates
- Rectangle color fill
- Local non-AI smart removal
- Seedream and OpenAI-compatible AI inpainting
- Selection-only compositing
- Crop, resize, PNG/JPG/WebP export
- ZIP download for all completed queue results
- Aliyun ECS deployment and health verification

## Install for Codex

```bash
mkdir -p ~/.codex/skills
git clone https://github.com/zhengrui0207-png/image-repair-skill.git ~/.codex/skills/image-repair-studio
```

Restart Codex after installation. The skill should trigger for requests involving selected-region image repair, batch repair, AI inpainting configuration, export sizing/cropping, or maintenance of the hosted service.

You can also download `image-repair-skill.skill` from the latest GitHub Release and import the packaged skill directly.

## Verify the hosted service

```bash
bash scripts/check_service.sh
```

API keys are not included in this repository and should never be committed.
