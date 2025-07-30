# -*- mode: python ; coding: utf-8 -*-

a = Analysis(
    ['../noScribe.py'],
    pathex=[],
    binaries=[('../ffmpeg', '.')],
    datas=[('../trans', 'trans/'), ('../models', 'models/'), ('../graphic_sw.png', '.'), ('../LICENSE.txt', '.'), ('../prompt.yml', '.'), ('../README.md', '.')],
    hiddenimports=['faster_whisper', 'faster_whisper.transcribe', 'faster_whisper.audio', 'faster_whisper.utils', 'Foundation', 'i18n'],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=['numba', 'llvmlite', 'scipy', 'pandas', 'matplotlib'],
    noarchive=False,
    optimize=0,
)

# Analysis for diarize.py
diarize_a = Analysis(
    ['../diarize.py'],
    pathex=[],
    binaries=[('../ffmpeg', '.')],
    datas=[('../pyannote', 'pyannote/')],
    hiddenimports=['pyannote.audio', 'torch', 'yaml'],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=['numba', 'llvmlite', 'scipy', 'pandas', 'matplotlib'],
    noarchive=False,
    optimize=0,
)

pyz = PYZ(a.pure)
diarize_pyz = PYZ(diarize_a.pure)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='noScribe',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon=['../noScribeLogo.icns'],
)

# Diarize executable
diarize_exe = EXE(
    diarize_pyz,
    diarize_a.scripts,
    [],
    exclude_binaries=True,
    name='diarize',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)

coll = COLLECT(
    exe,
    diarize_exe,
    a.binaries,
    diarize_a.binaries,
    a.datas,
    diarize_a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='noScribe',
)

app = BUNDLE(
    coll,
    name='noScribe.app',
    icon='../noScribeLogo.icns',
    bundle_identifier=None,
) 