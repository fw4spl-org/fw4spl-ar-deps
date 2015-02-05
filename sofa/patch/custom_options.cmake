########################
# Set custom options for builds (i.e for example, share between debug/release builds)
# ***** Applied only for the first configuration (does not touch the Cmake cache) *****
# After checking/unchecking options, save this file as "custom_options.cmake"

# OFF)
# setSofaOption(SOFA-SOFA-EXTERNAL_PNG OFF)
# setSofaOption(SOFA-EXTERNAL_GLEW ON) # TODO Check OS
# setSofaOption(SOFA-TUTORIAL_COMPOSITE_OBJECT OFF)
# setSofaOption(SOFA-TUTORIAL_MIXED_PENDULUM OFF)
# setSofaOption(SOFA-TUTORIAL_ONE_PARTICLE OFF)
# setSofaOption(SOFA-TUTORIAL_ONE_TETRAHEDRON OFF)
# setSofaOption(SOFA-LIB_COMPONENT_OPENGL_VISUAL OFF)
setSofaOption(SOFA-APPLICATION_GENERATERIGID OFF)
setSofaOption(SOFA-APPLICATION_MODELER OFF)
setSofaOption(SOFA-APPLICATION_RUNSOFA OFF)
setSofaOption(SOFA-LIB_COMPONENT_BOUNDARY_COMPONENT_BASE OFF)
setSofaOption(SOFA-LIB_COMPONENT_COMPONENT_ADVANCED OFF)
setSofaOption(SOFA-LIB_COMPONENT_COMPONENT_BASE   ON)
setSofaOption(SOFA-LIB_COMPONENT_COMPONENT_COMMON   ON)
setSofaOption(SOFA-LIB_COMPONENT_COMPONENT_GENERAL   ON)
setSofaOption(SOFA-LIB_COMPONENT_COMPONENT_MAIN   ON)
setSofaOption(SOFA-LIB_COMPONENT_COMPONENT_MISC   ON)
setSofaOption(SOFA-LIB_COMPONENT_CONSTRAINT    ON)
setSofaOption(SOFA-LIB_COMPONENT_DEFORMABLE    OFF)
setSofaOption(SOFA-LIB_COMPONENT_DENSE_SOLVER   OFF)
setSofaOption(SOFA-LIB_COMPONENT_EIGEN2_SOLVER   ON)
setSofaOption(SOFA-LIB_COMPONENT_ENGINE        ON)
setSofaOption(SOFA-LIB_COMPONENT_EULERIAN_FLUID   OFF)
setSofaOption(SOFA-LIB_COMPONENT_EXPLICIT_ODE_SOLVER   OFF)
setSofaOption(SOFA-LIB_COMPONENT_EXPORTER      ON)
setSofaOption(SOFA-LIB_COMPONENT_GRAPH_COMPONENT   OFF)
setSofaOption(SOFA-LIB_COMPONENT_HAPTICS       OFF)
setSofaOption(SOFA-LIB_COMPONENT_IMPLICIT_ODE_SOLVER   OFF)
setSofaOption(SOFA-LIB_COMPONENT_LOADER        ON)
setSofaOption(SOFA-LIB_COMPONENT_MESH_COLLISION   OFF)
setSofaOption(SOFA-LIB_COMPONENT_MISC          OFF)
setSofaOption(SOFA-LIB_COMPONENT_MISC_COLLISION   OFF)
setSofaOption(SOFA-LIB_COMPONENT_MISC_ENGINE   OFF)
setSofaOption(SOFA-LIB_COMPONENT_MISC_FEM      OFF)
setSofaOption(SOFA-LIB_COMPONENT_MISC_FORCEFIELD   ON)
setSofaOption(SOFA-LIB_COMPONENT_MISC_MAPPING   OFF)
setSofaOption(SOFA-LIB_COMPONENT_MISC_SOLVER   OFF)
setSofaOption(SOFA-LIB_COMPONENT_MISC_TOPOLOGY   OFF)
setSofaOption(SOFA-LIB_COMPONENT_NON_UNIFORM_FEM   ON)
setSofaOption(SOFA-LIB_COMPONENT_OBJECT_INTERACTION   OFF)
setSofaOption(SOFA-LIB_COMPONENT_OPENGL_VISUAL   ON)
setSofaOption(SOFA-LIB_COMPONENT_PARDISO_SOLVER   OFF)
setSofaOption(SOFA-LIB_COMPONENT_PRECONDITIONER   OFF)
setSofaOption(SOFA-LIB_COMPONENT_RIGID         OFF)
setSofaOption(SOFA-LIB_COMPONENT_SIMPLE_FEM    OFF)
setSofaOption(SOFA-LIB_COMPONENT_SPARSE_SOLVER   OFF)
setSofaOption(SOFA-LIB_COMPONENT_SPH_FLUID     OFF)
setSofaOption(SOFA-LIB_COMPONENT_FLOWVR     OFF)
setSofaOption(SOFA-LIB_COMPONENT_TAUCS_SOLVER   OFF)
setSofaOption(SOFA-LIB_COMPONENT_TOPOLOGY_MAPPING   OFF)
setSofaOption(SOFA-LIB_COMPONENT_USER_INTERACTION   OFF)
setSofaOption(SOFA-LIB_COMPONENT_VALIDATION    OFF)
setSofaOption(SOFA-LIB_COMPONENT_VOLUMETRIC_DATA   OFF)
setSofaOption(SOFA-LIB_GUI_GLUT OFF)
setSofaOption(SOFA-LIB_GUI_QT OFF)
setSofaOption(SOFA-LIB_GUI_QTVIEWER OFF)
setSofaOption(SOFA-LIB_SIMULATION_GRAPH_DAG OFF)
setSofaOption(SOFA-TUTORIAL_COMPOSITE_OBJECT OFF)
setSofaOption(SOFA-TUTORIAL_MIXED_PENDULUM OFF)
setSofaOption(SOFA-TUTORIAL_ONE_PARTICLE OFF)
setSofaOption(SOFA-TUTORIAL_ONE_TETRAHEDRON OFF)

# ON
#setSofaOption(SOFA-MISC_NO_OPENGL ON)

setSofaOption(SOFA-MISC_USE_FLOAT ON)

# PATH
setSofaPath(SOFA-EXTERNAL_QT5_PATH ${CMAKE_INSTALL_PREFIX}/lib)
setSofaPath(SOFA-EXTERNAL_LIBRARY_DIR ${CMAKE_INSTALL_PREFIX}/lib)
setSofaPath(SOFA-EXTERNAL_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/include)
