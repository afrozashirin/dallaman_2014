# Model for Type I Diabetes
### Description
This is a Matlab/Octave implementation of the system of ordinary differential equations (ODEs) that are described in Ref. 1.

### Installation and Usage
Using the model requires a recent (>2010) version of Matlab or Octave. Older versions may work but cannot be guaranteed.

#### File List
1. **DallaMan2014.m**: This function calls parameters.m, basal_states.m, and DallaMan2014fun.m . Running this script will produce the steady state values of the system. Change the amount of glucose (D), amount of insulin (uI), and amount of glucagon (uG) to compute all of the states.
2. **parameters.m**: The set of parameters.
3. **basal_states.m**: Compute the basal state of the system.
4. **DallaMan2014fun.m**: The system of ODs taken from the model presented in Ref. 1
5. **hill.m**, **maxfunc.m**, **delta.m** are the _smooth_ versions of the non-differentiable functions that appear in the model.

### References
1. Dalla Man, Chiara, et al. "The UVA/PADOVA type 1 diabetes simulator: new features." _Journal of diabetes sciences and technology_ 8.1 (2014) 26-34.
[Download Here](https://journals.sagepub.com/doi/abs/10.1177/1932296813514502)
