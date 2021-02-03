---
tags:
    - stat196k
---

Here is a tentative outline of topics for STAT 196K.
The goal of the course is to achieve the following learning outcomes.


## Learning Outcomes

Students will be able to:

1. Develop complete statistical computer programs based on high level directions, using standard software packages. 
    Their programs will be complete in the sense that they start with processing raw data, and finish by producing final summaries and results necessary for reports.
3. Apply standard statistical techniques suitable for data larger than memory, for example, the split-apply-combine strategy for grouped data, memory efficient streaming statistics, discretization, and dimension reduction through principal components analysis.
4. Identify, extract, and summarize elements of interest from complex data sets, including tabular, hierarchical, streaming, image, and text data.
2. Summarize their approach and conclusions for a data analysis problem through technical written reports with appropriate graphics.
5. Perform data analysis using remote machines, which may include databases, remote compute clusters, and cloud services.
6. Accelerate and scale data analysis programs by identifying and fixing performance bottlenecks.


## Assignments

We'll have around 5 large assignments in the class, each focused on a different kind of data or problem.
Each assignment covers most of the above learning outcomes, with varying levels of emphasis.
For example, we will run the programs for all the assignments on AWS, so all the assignments support the learning outcome "Perform data analysis using remote machines".

1. __Large Text Data__ is one or more text files larger than memory.
    Example: CSV file with many rows.
2. __Nested Data__ has a hierarchical, nested structure in one or many files, possibly larger than memory.
    Example: XML, JSON.
3. __Relational Databases__ contain many related tables to join together.
    Example: Remote database server accessed via a SQL client.
4. __Images__ are collections of pictures, one per file.
    We're going to use off the shelf high level image processing software in our language of choice rather than implement the details ourselves.
    Example: PNG, JPG.
5. __Simulation__ could be based on any kind of data or random process.
    A pandemic simulation based on actual physical population densities could be very interesting.

These assignments require specific computing skills to complete as illustrated in the image below.
The edges represent prerequisites, with solid lines representing strict prerequisites or connections, and dashed lines representing more optional connections.
For example, the solid edge from "shell basics" to "version control" indicates that students should learn "shell basics" before "version control".
Shaded boxes represent assignments, and the blue ovals on the right represent statistical concepts.

![assignment dependency]({% link img/order.svg %})

There are more possible edges, but the graph seems busy enough as it is.
