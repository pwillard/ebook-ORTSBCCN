=== Adding Shine to Models (Paul Gausden)

I have long believed that there was far more functionality available in the graphics engine than was being used by modellers.

I had spent many hours looking at the `app.fbk` and `default.fbk` files as well as the `S` file format. All of these pointed towards the fact that bump maps and environment maps should work. But how ?

I made many experimental *S* files, none of which worked.

However, thanks to a posting by "Vital" from trainsim.ru on the 3Dtrains.com forums I found out someone had enabled environment maps.

image::images/decapod_shine_01.jpg[]

[NOTE]
Converting one of my models (3D canvas model) - even transparent textures got environment maps added. I spotted the information I was missing from my *S* files and suddenly I had access to more named shaders. In reality not many of them are useful, but some have a big impact.


==== GlessMap

The first one to try is "GlossMap". This is environment mapping (behaves a bit like a reflection) on flat textures.

Prerequisite:

* A model with a texture that has a flat surface.

----
*** To enable this, app.fbk in the main trainsim folder needs a small patch ***

open the file with wordpad;
look for:
   shader_cfgs (
               22
change to:
   shader_cfgs (
               23
----
