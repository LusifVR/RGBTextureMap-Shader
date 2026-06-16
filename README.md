# RGBTextureMap-Shader
.Shader file for capturing the classic vertex painting trick used in games but with a UV map. Support for 3 tiled textures via RGB channels along with normals, a shared AO map, smoothness map, emission map, and optimized all into a GPU instanced single material.

<img width="1002" height="790" alt="image" src="https://github.com/user-attachments/assets/4b6ea57d-a7bb-4b00-a781-145891e1f7e2" />

You can use it to create interesting and easily optimized texutre maps for meshes.
Acting as a RGB mask directly onto the mesh where you could paint tiled textures.

Similar to how Unity's terrain paint works, you can use Blender (or another 3d software)
to paint the colors matching to the materials, making it easy for a multi-texture material
without having to worry about complex UVs, intense drawcalls, or any of that mess.
