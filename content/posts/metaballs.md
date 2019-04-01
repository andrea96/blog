---
title: "Metaballs and marching cubes"
date: 2018-12-19T21:02:38+01:00
draft: false
---

In the last days I started playing with [three.js](https://threejs.org),
basically it's a *JavaScript* library that manages animated 3d objects and
permits to render them.
I was interested in computer graphics and I found this library a wonderful
sandbox capable of running in my browser as a simple *Canvas* (thanks to
[WebGL](https://www.khronos.org/webgl/)).

In this post I'm going to explain how I implemented the famous
[Marching cubes](https://en.wikipedia.org/wiki/Marching_cubes) algorithm.
I want to underline the fact that I'm not an expert, I discovered this algorithm
some days ago because I wanted display two Metaballs, so this post is for fun,
simply don't expect a super-efficient implementation.

This is my final result, I hope you like it.

<script src="/js/threejs/three.min.js"></script>
<script src="/js/threejs/OrbitControls.js"></script>
<script src="/js/threejs/dat.gui.min.js"></script>
<script src="/js/threejs/stats.min.js"></script>
<script src="/js/threejs/mc.js"></script>
<script src="/js/threejs/scene.js"></script>

<script>var width=document.getElementsByTagName("main")[0].offsetWidth-5;var height=width*9/16;var renderer=new THREE.WebGLRenderer();renderer.setSize(width,height);document.getElementsByTagName("main")[0].appendChild(renderer.domElement);function MetaBall(xCenter,yCenter,zCenter){this.xCenter=xCenter;this.yCenter=yCenter;this.zCenter=zCenter;this.fun=function(x,y,z){return 1/Math.sqrt(Math.pow(x-this.xCenter,2)+Math.pow(y-this.yCenter,2)+Math.pow(z-this.zCenter,2));};}
var mb1=new MetaBall(0,0,5);var mb2=new MetaBall(0,0,0);var scene=new THREE.Scene();var camera=new THREE.PerspectiveCamera(45,width/height,0.1,10000);camera.position.x=-10;camera.position.y=4;camera.position.z=-7;scene.add(camera);var light=new THREE.PointLight(0xffffff);light.position.set(-100,200,100);scene.add(light);var controls=new THREE.OrbitControls(camera,renderer.domElement);var axes=new THREE.AxisHelper(50);scene.add(axes);var geometry=new THREE.Geometry();var material=new THREE.MeshPhongMaterial({});var mesh=new THREE.Mesh(geometry,material);scene.add(mesh);camera.lookAt(mesh);var ambLight=new THREE.AmbientLight(0x404040);scene.add(ambLight);window.addEventListener('resize',resize);resize();animate();function resize(){let w=document.getElementsByTagName("main")[0].offsetWidth-5;let h=w*9/16;renderer.setSize(w,h);camera.aspect=w/h;camera.updateProjectionMatrix();}
var time=0;function animate(){time+=0.1;mb1.zCenter=(Math.sin(time*0.4)+1)*5;mesh.geometry.dispose();mesh.geometry=createGeometry(function(x,y,z){return(mb1.fun(x,y,z)+mb2.fun(x,y,z));},0.5,new THREE.Vector3(-10,-10,-10),new THREE.Vector3(20,20,20),24);renderer.render(scene,camera);controls.update();requestAnimationFrame(animate);}</script>


Let's try to move around the metaballs using the mouse!

What is a metaball?
==================

Let `$metaball_i(x, y, z)$` be the function associated with the `$i$`-th
metaball, a typical example of such a function is the reciprocal of the euclidean
distance from the center of the metaball;

`$$ metaball_i(x, y, z) =  \frac{1}{(x_i - x)^2 + (y_i - y)^2 + (z_i - z)^2}$$`

where `$(x_i, y_i, z_i)$` is the center of the `$i$`-th metaball.

Then the implicit surface defined by the metaballs (which could be disconnected)
is simply the set of the points `$(x, y, z)$` that satisfy

`$$ \sum_{i=1}^{n} metaball_i(x, y, z) < t $$`

where `$t$` is a constant threshold. Changing the value of `$t$` allows to
modify how much the metaballs attract each other.

Marching cubes
==============

Soon there will be the explaination of the algorithm!
Meanwhile this is the code:

<code data-gist-id="8a5a9a5ce761d4a8f7fd28d9aad4614f"></code>
