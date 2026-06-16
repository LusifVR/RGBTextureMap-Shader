# RGBTextureMap-Shader
.Shader file for capturing the classic vertex painting trick used in games but with a UV map. Support for 3 tiled textures via RGB channels along with normals, a shared AO map, smoothness map, emission map, and optimized all into a GPU instanced single material.

<img width="1002" height="790" alt="image" src="https://github.com/user-attachments/assets/c1cf44f5-6ec4-45e4-8e3c-d71152bb52b7" />

You can use it to create interesting and easily optimized texutre maps for meshes.
Acting as a RGB mask directly onto the mesh where you could paint tiled textures.

Similar to how Unity's terrain paint works, you can use Blender (or another 3d software)
to paint the colors matching to the materials, making it easy for a multi-texture material
without having to worry about complex UVs, intense drawcalls, or any of that mess.
