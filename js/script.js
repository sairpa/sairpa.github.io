import * as THREE from 'three';
    import { OrbitControls } from 'https://unpkg.com/three@0.141.0/examples/jsm/controls/OrbitControls.js';

    const width = window.innerWidth
    const height = window.innerHeight
    const day = new THREE.Color(0x0c2943);
    const duskdawn = new THREE.Color(0x004f38);
    const night = new THREE.Color(0x590023);
    const nightdown = new THREE.Color(0x00264c);
    let t = 0;

    const scene = new THREE.Scene()
    scene.background = new THREE.Color();
    const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000)

    const renderer = new THREE.WebGLRenderer()
    renderer.setSize(width, height)
    document.body.appendChild(renderer.domElement)

    const pointLight = new THREE.PointLight(0xffffff);
    pointLight.position.set(5, 5, 5);

    const ambientLight = new THREE.AmbientLight(0xffffff);
    scene.add(pointLight, ambientLight);

    function addStar() {
  const geometry = new THREE.SphereGeometry(Math.random()*0.25.toPrecision(2), 12.5, 12.5);
  const material = new THREE.MeshStandardMaterial({ color: Math.random() * 0xffffff });
  const star = new THREE.Mesh(geometry, material);

  const [x, y, z] = Array(3)
    .fill()
    .map(() => THREE.MathUtils.randFloatSpread(100));

  star.position.set(x, y, z);
  scene.add(star);
}

Array(1000).fill().forEach(addStar);

    camera.position.set(5,5,5);

    
    // plane to display
    // const img_plane = new Image();
    // img_plane.crossOrigin = "";   
    // img_plane.src = "./images/me.png";
    // const texture_plane = new THREE.Texture(img_plane);
    // img_plane.onload = () => { texture_plane.needsUpdate = true };
    // const geometry_plane = new THREE.PlaneGeometry(10,10,10);
    // const mei = new THREE.Mesh(geometry_plane,
    //     new THREE.MeshLambertMaterial({ map: texture_plane }))
    // mei.position.set(0,0,0);
    // scene.add(mei);


    var scrollPos = 0;
    function moveCamera() {
      const t = document.body.getBoundingClientRect().top;
      
      // camera.position.x = t * -0.0002;
      // camera.rotation.y = t * -0.0002;
     
      // if(document.body.getBoundingClientRect().top == 0){
      //   camera.target.position.copy( mei.position );
        
      // }

      if ((document.body.getBoundingClientRect()).top > scrollPos){
        
        camera.position.z = -t * 0.001;
        camera.rotation.x -= t*0.000005;
      }
      else{
        
        camera.position.z = t * 0.001;
        camera.rotation.x += t*0.000005;
      }
      // saves the new position for iteration.
      scrollPos = (document.body.getBoundingClientRect()).top;
    }

    document.body.onscroll = moveCamera;
    moveCamera();

    function resize() {
      var aspect = window.innerWidth / window.innerHeight;
      camera.aspect = aspect;
      camera.updateProjectionMatrix();
      renderer.setSize(window.innerWidth, window.innerHeight);
  }
  window.addEventListener('resize', resize, false);
  resize();

    const controls = new OrbitControls(camera, renderer.domElement)

    function animate() {
      var current = new Date();
      if(current.getHours() > 12){
        scene.background.copy(night).lerp(nightdown, 0.75 * (Math.sin(t) + 1));
      }
      else{
        scene.background.copy(day).lerp(duskdawn, 0.75 * (Math.sin(t) + 1));
      }
        requestAnimationFrame(animate)
        renderer.render(scene, camera)
        t += 0.01;

        
        // console.log("Camera")
        // console.log(camera.rotation)
        // console.log("cam pos")
        // console.log(camera.position)
        // console.log("Image")
        // console.log(mei.rotation)
    }

    animate()