if ! command -v python >/dev/null 2>&1
then
    echo Please install python or activate the appropriate conda environment.
fi

# install pyrosetta [can comment if you already have it or have an old version]
python -m pip install pyrosetta --find-links https://graylab.jhu.edu/download/PyRosetta4/archive/release-quarterly/release

# install pybind11-stubgen
python -m pip install pybind11-stubgen

# run pybind11-stubgen, outputting stubs to './pyrosetta'
python -m pybind11_stubgen pyrosetta -o . || exit #make sure we make stubs correctly before copying/removing

#get site packages folder. customize if needed
sitepackages=$(python -c "import site; print(site.getsitepackages()[0])")

# copy stubs to site-packages
rsync -r ./pyrosetta/rosetta "${sitepackages}/pyrosetta"

#cleanup stubs
rm -r pyrosetta

echo Stubs copied to site-packages.