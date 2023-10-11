// PRACTICA NRO 1: MONGODB

// 1 - Crear una base de datos llamada biblioteca

use ('biblioteca');

// 2 - Crear una colección llamada socios

db.createCollection('socios');


// 3 - Crear una colección llamada libros

db.createCollection('libros');

// 4 - Mostrar todos las colecciones de la base de datos biblioteca

show collections

// 5 - Insertar los siguientes documentos en la colección libros

// codigo: 1,  
//     nombre: 'El aleph',
//     autor: 'Borges',
//     editoriales: ['Planeta','Siglo XXI']
// codigo: 2,
//     nombre: 'Martin Fierro',
//     autor: 'Jose Hernandez',
//     editoriales: ['Planeta']
// codigo: 3,  
//       nombre: 'Aprenda PHP',
//       autor: 'Mario Molina',
//       editoriales: ['Planeta']
// codigo: 4,  
//       nombre: 'Java en 10 minutos',
//       autor: 'Barros Sergio',
//       editoriales: ['Planeta','Siglo XXI']

db.libros.insertMany(
  [
    {
      codigo: 1,  
      nombre: 'El aleph',
      autor: 'Borges',
      editoriales: ['Planeta','Siglo XXI']
    },
    {
      codigo: 2,
      nombre: 'Martin Fierro',
      autor: 'Jose Hernandez',
      editoriales: ['Planeta']
    },
    {
      codigo: 3,  
      nombre: 'Aprenda PHP',
      autor: 'Mario Molina',
      editoriales: ['Planeta']
    },
    {
      codigo: 4,  
      nombre: 'Java en 10 minutos',
      autor: 'Barros Sergio',
      editoriales: ['Planeta','Siglo XXI']
    }
  ]
)
6 - Mostrar los documentos de libros

db.libros.find()

7 - Mostrar el documento cuyo autor es Borges

db.libros.find({autor: 'Borges'})

8 - Solo mostrar los 2 primeros documentos

db.libros.find({}).limit(2)

9 -Agregar los siguientes campos
codigo: 1----> precio: 20,cantidad: 50
codigo: 2 a 4----> precio: 50,cantidad: 12

db.libros.updateOne({codigo: 1}, {$set: {precio: 20, cantidad:50}})

db.libros.updateOne({codigo: }, {$set: {precio 50, cantidad: 12}})

10 - Modificar los siguientes campos
codigo: 3----> precio: 50,cantidad: 20
codigo: 4----> precio: 45,cantidad: 1

db.libros.updateOne({codigo: 3}, {$set: {precio:50, cantidad:20}})
db.libros.updateOne({codigo: 4}, {$set: {precio:50, cantidad:1}})

11 - Mostrar aquellos libros que tienen mas de 10 unidades en stock

12 - Mostrar aquellos libros que tengan 50 unidades en stock y un precio es $20
13 - Mostrar aquellos libros que tengan 50 unidades en stock o un precio es $50
14 - Recuperar todos los libros que en le campo cantidad hay un valor distinto a 50:
15 -Recuperar todos los libros cuyo precio estén comprendidos entre 20 y 45
16 . Recuperar todos los libros de la editorial Siglo XX
17 - Borrar todos los libros que tienen un precio mayor o igual a 50 
18 - Agregar la editorial Atlantida al libro cuyo codigo es 1
19 - Modificar el contenido del documento cuyo codigo es 1 de forma tal que solamente tenga el codigo 1 y el campo prueba en 0(usar replace)
20 - Borrar el documento modificado en el punto 19


