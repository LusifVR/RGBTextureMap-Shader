# RGBTextureMap-Shader
.Shader file for capturing the classic vertex painting trick used in games but with a UV map. Support for 4 tiled textures via RGB channels along with normals, a shared AO map, smoothness map, emission map, and optimized all into a GPU instanced single material.

I developed this for a couple games im working on, but several people showed interest so now its public and free to use! Enjoy! :)

#### Red - Channel 1 | Green - Channel 2 | Blue - Channel 3 | Black - Channel 4
Optional support for smoothness map, emission map, occlusion map, and an overlay map.

<img width="1002" height="790" alt="image" src="https://github.com/user-attachments/assets/4b6ea57d-a7bb-4b00-a781-145891e1f7e2" />

It supports overlapping colors as well, so you can use it to easily blend multiple textures together
For example, coloring damage on a brick wall.

<img width="1436" height="795" alt="image" src="https://github.com/user-attachments/assets/b254dd19-b420-478c-81d6-3b18961cefcf" />

You can use it to create interesting and easily optimized texutre maps for meshes.
Acting as a RGB mask directly onto the mesh where you could paint tiled textures.

It also supports Emission!
<img width="916" height="664" alt="image" src="https://github.com/user-attachments/assets/d0530ee5-7de9-4042-aa52-9a97b4e31c98" />


Similar to how Unity's terrain paint works, you can use Blender (or another 3d software)
to paint the colors matching to the materials, making it easy for a multi-texture material
without having to worry about complex UVs, intense drawcalls, or any of that mess.

<img width="844" height="660" alt="image" src="https://github.com/user-attachments/assets/6de4a3b0-6317-4620-b804-52570c61f345" />

Then, our RGB gets mapped to the set textures (solid colors for reference)
And finally our black (no RGB value) gets mapped to a 4th texture

<img width="831" height="764" alt="image" src="https://github.com/user-attachments/assets/3fc18ab5-2493-4adf-887d-538ae08fb896" />



