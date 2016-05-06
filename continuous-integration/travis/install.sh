MINICONDA_URL="http://repo.continuum.io/miniconda"

if [ ${TRAVIS_PYTHON_VERSION:0:1} == "2" ]; then
    travis_retry wget "${MINICONDA_URL}/Miniconda2-latest-Linux-x86_64.sh" -O miniconda.sh;
else
    travis_retry wget "${MINICONDA_URL}/Miniconda3-latest-Linux-x86_64.sh" -O miniconda.sh;
fi
chmod +x miniconda.sh
./miniconda.sh -b -p "${HOME}/miniconda"
export PATH="${HOME}/miniconda/bin:${PATH}"
hash -r
conda config --set always_yes yes --set changeps1 no
conda update -q conda
conda install pip conda-build jinja2 binstar
