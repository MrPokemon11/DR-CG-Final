# Explanations
## Stencil
The stencil shader was used to implement the background of the scene. The background consists of three objects: The "front" of the stencil, which forms the positive space of the clouds, the "back" of the stencil, which forms the clouds themselves, and the background, which fills the negative space. This is different from the stencil shader shown in class, because it renders the union of the back and the front, instead of the difference.
### Diagram
<img width="301" height="401" alt="StencilBreakdown" src="https://github.com/user-attachments/assets/8fccc009-1cb2-42d1-943c-f53ec3415e4d" />

## Polygon Surface Deformation
The surface deformation shader was used to create waves in the water below the bridge. I used the abs function to get the absolute value from the sine function to give the waves the pointed look of those in the original game. It was done this way because sine waves create too smooth of a curve, so taking the absolute value creates properly pointed waves.

## Scrolling Texture
The scrolling texture was implemented as the farthest layer of the background (behind the stencil) and was made to look like snow falling from the sky. The two layers were offset, allowing for more snow to be visible at once, making it look like there is a blizzard. 

## Rim Lighting
Rim lighting was used to make the bridge look more like the one in the provided image, with a black outline around the outside. This was done by subtracting the rim light from the base color, darkening the edges instead of brightening them.

