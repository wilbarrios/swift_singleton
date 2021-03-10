# Automated Testing

- To enable automated testing on our projects, we need to configure and specific `target` to achive that. But, let's see what a *target* is:

A target specifies a product to build and contains the instructions for building the product from a set of files in a project or workspace. A target defines a single product; it organizes the inputs into the build system—the source files and instructions for processing those source files—required to build that product. Projects can contain one or more targets, each of which produces one product.

A target and the product it creates can be related to another target. If a target requires the output of another target in order to build, the first target is said to depend upon the second. If both targets are in the same workspace, Xcode can discover the dependency, in which case it builds the products in the required order. Such a relationship is referred to as an implicit dependency. You can also specify explicit target dependencies in your build settings, and you can specify that two targets that Xcode might expect to have an implicit dependency are actually not dependent. For example, you might build both a library and an application that links against that library in the same workspace. Xcode can discover this relationship and automatically build the library first. However, if you actually want to link against a version of the library other than the one built in the workspace, you can create an explicit dependency in your build settings, which overrides this implicit dependency.

[Developer Apple](https://developer.apple.com/library/archive/featuredarticles/XcodeConcepts/Concept-Targets.html#:~:text=A%20target%20specifies%20a%20product,in%20a%20project%20or%20workspace.&text=A%20target%20inherits%20the%20project,settings%20at%20the%20target%20level.)

Knowing this, we can say a set of tests or a target, is a complete product, like an aplication, needs to build, make a binary and needs a file with a set of settings to make that happend.

To confirm this, when you create a test target you need to provide a *product name* same as an application or framework creation

## To run tests, you need a scheme

An Xcode scheme defines a collection of targets to build, a configuration to use when building, and a collection of tests to execute.

*You can have as many schemes as you want, but only one can be active at a time*. You can specify whether a scheme should be stored in a project—in which case it’s available in every workspace that includes that project, or in the workspace—in which case it’s available only in that workspace. When you select an active scheme, you also select a run destination (that is, the architecture of the hardware for which the products are built).

[Developer Apple](https://developer.apple.com/library/archive/featuredarticles/XcodeConcepts/Concept-Schemes.html#//apple_ref/doc/uid/TP40009328-CH8-SW1)
