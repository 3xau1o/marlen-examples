{
  "m": {
    "l": "ts",
    "e": {
      "k": "p5js",
      "p": {
        "v": "1",
        "ml5": false,
        "sound": false
      }
    }
  },
  "i": {
    "ai": {
      "c": {}
    }
  },
  "o": {
    "c": {}
  },
  "fs": {
    "k": "tree",
    "v": 1,
    "r": {
      "k": 0,
      "c": {
        "index.ts": {
          "k": 1,
          "c": "// ============================================================\n//  EJEMPLO DE POINTER LOCK (BLOQUEO DEL PUNTERO) EN p5.js\n//  - Haz clic en el canvas para bloquear el mouse\n//  - Mueve el mouse para mirar alrededor (cámara)\n//  - Vuelve a hacer clic mientras está bloqueado → \"dispara\"\n//  - Presiona ESC para liberar el puntero\n// ============================================================\n\nlet camX = 0;            // desplazamiento horizontal de la \"cámara\"\nlet camY = 0;            // desplazamiento vertical de la \"cámara\"\nlet bloqueado = false;   // indica si el puntero está bloqueado\nlet canvasEl = null;     // referencia al elemento <canvas> del DOM\n\n// --- Lista de \"disparos\" activos ---\nlet disparos = [];\n\nfunction setup() {\n  canvasEl = createCanvas(600, 400).elt;\n\n  // --- Detectar cuando se activa/desactiva el bloqueo ---\n  document.addEventListener(\"pointerlockchange\", () => {\n    bloqueado = document.pointerLockElement === canvasEl;\n    print(\"Puntero bloqueado:\", bloqueado);\n  });\n\n  // --- Capturar movimiento del mouse mientras está bloqueado ---\n  document.addEventListener(\"mousemove\", (e) => {\n    if (bloqueado) {\n      // movementX / movementY = cuánto se movió el mouse desde el último evento\n      camX += e.movementX;\n      camY += e.movementY;\n    }\n  });\n\n  textAlign(CENTER, CENTER);\n  textSize(18);\n}\n\nfunction draw() {\n  // Fondo: cambia de color según el estado\n  if (bloqueado) {\n    background(20, 30, 50);   // azul oscuro = bloqueado\n  } else {\n    background(50, 20, 30);   // rojo oscuro = libre\n  }\n\n  // --- Escena que responde al movimiento de la \"cámara\" ---\n  push();\n  translate(width / 2, height / 2);\n\n  // Parrilla (grid) que se desplaza con el mouse\n  stroke(100, 180, 255, 80);\n  strokeWeight(1);\n  for (let i = -10; i <= 10; i++) {\n    let x = i * 50 + camX;\n    line(x, -300, x, 300);\n  }\n  for (let j = -10; j <= 10; j++) {\n    let y = j * 50 + camY;\n    line(-300, y, 300, y);\n  }\n\n  // Círculo de referencia que se mueve con la cámara\n  noStroke();\n  fill(255, 200, 50);\n  ellipse(camX % 300, camY % 300, 40, 40);\n\n  pop();\n\n  // --- Dibujar todos los \"disparos\" activos ---\n  for (let i = disparos.length - 1; i >= 0; i--) {\n    let d = disparos[i];\n    d.vida -= 2;  // se desvanece\n\n    if (d.vida <= 0) {\n      disparos.splice(i, 1);  // eliminar cuando se apaga\n      continue;\n    }\n\n    // Anillo expansivo\n    let radio = map(d.vida, 100, 0, 5, 60);\n    let alpha = map(d.vida, 100, 0, 255, 0);\n\n    push();\n    noFill();\n    stroke(255, 255, 100, alpha);\n    strokeWeight(3);\n    ellipse(d.x, d.y, radio * 2);\n    // Punto central\n    stroke(255, 200, 50, alpha);\n    strokeWeight(6);\n    point(d.x, d.y);\n    pop();\n  }\n\n  // --- Mira (crosshair) cuando está bloqueado ---\n  if (bloqueado) {\n    push();\n    stroke(0, 255, 0);\n    strokeWeight(2);\n    noFill();\n    ellipse(width / 2, height / 2, 30, 30);\n    line(width / 2 - 18, height / 2, width / 2 + 18, height / 2);\n    line(width / 2, height / 2 - 18, width / 2, height / 2 + 18);\n    fill(0, 255, 0, 60);\n    noStroke();\n    ellipse(width / 2, height / 2, 10, 10);\n    pop();\n  }\n\n  // --- Textos de instrucción (en español) ---\n  fill(255);\n  noStroke();\n  if (!bloqueado) {\n    text(\"🖱 Haz clic en el canvas para bloquear el puntero\\n(Presiona ESC para liberar)\", width / 2, 30);\n  } else {\n    text(\"🔒 Puntero bloqueado — mueve el mouse para mirar\\n🖱 Haz clic para disparar  |  ESC = liberar\", width / 2, 30);\n  }\n\n  // Valores de depuración\n  fill(200);\n  textSize(14);\n  text(\"camX: \" + camX + \"  |  camY: \" + camY + \"  |  disparos: \" + disparos.length, width / 2, height - 20);\n}\n\n// --- Reaccionar al clic ---\nfunction mousePressed() {\n  if (!bloqueado) {\n    // Si no está bloqueado → solicitar bloqueo\n    if (canvasEl) {\n      canvasEl.requestPointerLock();\n    }\n  } else {\n    // Si ya está bloqueado → ¡disparar!\n    agregarDisparo(width / 2, height / 2);\n  }\n}\n\n// --- Crea un nuevo efecto de disparo en (x, y) ---\nfunction agregarDisparo(x, y) {\n  disparos.push({\n    x: x,\n    y: y,\n    vida: 100  // duración del efecto en frames\n  });\n  // Pequeña sacudida visual (recoil simulado)\n  camX += random(-3, 3);\n  camY += random(-3, 3);\n}\n"
        }
      }
    }
  }
}