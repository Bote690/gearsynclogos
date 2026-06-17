# GearSync Logos

Public logo catalog for GearSync.

The public catalog is intentionally curated. Only transparent, full-color or project-approved logos should be added.

Catalog URL:

```text
https://raw.githubusercontent.com/Bote690/gearsynclogos/main/logos.json
```

## Import workflow

1. Download or place approved logo files in `_incoming/`.
2. Use clear filenames such as `audi.png`, `bmw.svg`, `seat.webp`.
3. Run:

```powershell
./tools/import-incoming.ps1
```

4. Review `logos.json` and fill `sourceUrl`, `license`, `usage`, and `status` if needed.
5. Commit and push.

The importer accepts `.png`, `.svg`, `.webp`, `.jpg`, and `.jpeg`.

## Review files

- `brands-to-source.md`: target brand checklist.
- `official-sources.md`: official media/press source candidates.
- `official-logo-assets.md`: reviewed official asset links and import status.
