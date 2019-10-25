# ANN-Solo
ANN-Solo docker image based on nvidia/cuda:10.1-devel-ubuntu18.04. Installed in an anaconda virtual environment using:
- python 3.7
- faiss-gpu on Cuda 10 package
- rdkit

To use it build the image using (from the repo folder):
```docker
docker image build -t ann_solo:latest .
```

This will create an ann_solo:latest image
To run it call:
```docker
docker run -it ann_solo:latest
```

This should give you bash terminal already in my-rdkit-env virtual environment with ann_solo ready to use
Can be called as follows:

```bash
ann_solo <your_splib_file_name> <your_mgf_file_name> <result_file_name_of_your_choice> --precursor_tolerance_mass=<tolerance_value> --precursor_tolerance_mode=<Da_or_ppm> --fragment_mz_tolerance=<mz_tolerance_value>
```

Other parameters also available. This is just the bare minumum that needs to be set up to make it work [link to ANN-Solo](https://github.com/bittremieux/ANN-SoLo/tree/master/src).
