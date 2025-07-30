# Custom hook for lightning_fabric to fix version.info issue
from PyInstaller.utils.hooks import collect_data_files
from PyInstaller.utils.hooks import collect_submodules

# Collect all submodules
hiddenimports = collect_submodules('lightning_fabric')

# Collect data files
datas = collect_data_files('lightning_fabric')

# Fix for missing version.info file
import os
import lightning_fabric
lightning_fabric_path = os.path.dirname(lightning_fabric.__file__)
version_info_path = os.path.join(lightning_fabric_path, 'version.info')

if os.path.exists(version_info_path):
    datas.append((version_info_path, 'lightning_fabric'))
else:
    # Create a dummy version.info file if it doesn't exist
    dummy_version_info = os.path.join(os.path.dirname(__file__), 'lightning_fabric_version.info')
    with open(dummy_version_info, 'w') as f:
        f.write('0.0.0\n')
    datas.append((dummy_version_info, 'lightning_fabric/version.info')) 