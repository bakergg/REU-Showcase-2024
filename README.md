# REU-Showcase-2024
# Open-Source Software for Generalized Tensor Decomposition


## Introduction
This summer, I had the opportunity to contribute to the development of the [GCPDecompositions.jl](https://github.com/dahong67/GCPDecompositions.jl) package. This package is designed for performing Generalized CP (GCP) tensor decomposition, a powerful tool in multi-dimensional (tensor) data analysis. Check out the [original repository](https://github.com/dahong67/GCPDecompositions.jl) for more details.

**This project has been a significant part of my learning journey, and I am excited to share this work with you. Thanks for visiting!** :)

![Department of Electrical and Computer Engineering](https://1000logos.net/wp-content/uploads/2022/07/University-of-Delaware-Seal-768x432.png)

## Abstract of Work
Generalized tensor decomposition is a method for extracting simple patterns from complicated and large data.  It does so by decomposing a multi-dimensional array of data (i.e., a tensor) into a sum of simple rank-one tensors that each capture a single latent phenomenon/pattern.  Computing generalized tensor decompositions involves techniques and ideas from applied mathematics, statistics, and electrical engineering, and its applications span the vast field of data science.  Our project focused on contributing to an open-source software package for performing Generalized Canonical Polyadic (GCP) Decomposition, an extension of traditional CP tensor decomposition that offers broader applicability and user flexibility.  Our first contribution is in creating software demos to showcase the technique.  We considered datasets from significantly different domains: neural experiments and historical NBA game statistics.  In both cases, GCP uncovered intriguing patterns, identifying condition-specific neural behavior in the neuroscience data and team dynamics in the sports analytics data.  Our second contribution is in developing additional toolsets that help streamline working with tensor decompositions.  These include a function that normalizes the factors in a tensor decomposition, by redistributing their scalings into the decomposition weights, and a function for visualizing the tensor decompositions, which is a crucial part of analyzing and interpreting the results.  Finally, we contributed to the implementation of stochastic algorithms for GCP that will enable the package to handle larger datasets with less computational cost.  In particular, we have worked on implementing stochastic gradients that can be computed much faster than the full gradients currently used in the package. Overall, our contributions aim to help users see the power and versatility of GCP in data science, improve their workflow, and reduce the computational costs, making the benefits of tensor decomposition ever more accessible to a broader audience.

---

## Improvements to the Package
One aspect I focused on this summer was software development.  Specifically, I was in charge of enhancing the functionality and usability of the GCPDecompositions.jl package and I was primarily involved in translating mathematical phenomena into executable code. 

Below are some of the key functions/algorithms I made:

- Computing Stochastic Gradients
- Normalization of Factors using p-norms
- Decomposition Visualization
- 🚧 Adam Optimization (in progress!) 🚧

For detailed demonstrations of these new additions, please visit the [Software Development Folder](https://github.com/bakergg/REU-Showcase-2024/tree/main/Software%20Development).

---

## Demos
To showcase the versatility and capabilities of the GCPDecompositions.jl package, I created several demos using real-world data. These demos showcase how tensor decomposition can be applied to diverse types of data from significantly different domains.

Explore the [Demos Folder](https://github.com/bakergg/REU-Showcase-2024/tree/main/Demos) to see all the examples and their results:
- [Neural Experiments Data](https://github.com/bakergg/REU-Showcase-2024/blob/main/Demos/Neuroscience%20Demo.pdf)
- [NBA History Data](https://github.com/bakergg/REU-Showcase-2024/blob/main/Demos/Sports%20Analytics%20Demo.pdf)


---

## About Me
My name is Gianna Baker and I am a junior at Washington and Jefferson College where I study Mathematics and Computer Science.  I am always in search of learning experiences and opportunities that can incorporate both areas of interest.  In particular, I am interested in linear algebra, calculus, and software development/engineering.  Feel free to connect with me on [LinkedIn](https://www.linkedin.com/in/gianna-baker/).

---

## Acknowledgements and References
I want to give a big thank you to my research mentor Dr. Hong and the ECE Department at the University of Delaware.

[1] Kolda, Bader. “Tensor Decompositions and Applications.” SIAM Review (2009).

[2] Hong, Kolda, Duersch. “Generalized Canonical Polyadic Tensor Decomposition.” SIAM Review (2020).

[3] Kolda, Hong. “Stochastic Gradients for Large-Scale Tensor Decomposition.” SIAM Journal on Mathematics of Data Science (2020).






