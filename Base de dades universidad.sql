-- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT persona.nombre, persona.apellido1,persona.apellido2 FROM persona WHERE tipo LIKE "alumno" ORDER BY apellido1, apellido2, nombre;
-- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT persona.nombre, persona.apellido1, persona.apellido2 FROM persona WHERE tipo LIKE "alumno" AND persona.telefono IS NULL;
-- Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona WHERE tipo LIKE "alumno" AND persona.fecha_nacimiento LIKE "1999%";
-- Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona WHERE tipo LIKE "profesor" AND persona.telefono IS NULL AND persona.nif LIKE "%K";
-- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura WHERE asignatura.cuatrimestre = 1 AND asignatura.curso = 3 AND id_grado = 7;
-- Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY persona.apellido1, persona.apellido2, persona.nombre;
-- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM asignatura JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE persona.nif LIKE "26902806M";
-- Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT departamento.nombre FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_grado = 4;
-- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT * FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno WHERE alumno_se_matricula_asignatura.id_curso_escolar = 5;
-- Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre FROM persona RIGHT JOIN profesor ON persona.id = profesor.id_profesor RIGHT JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;
-- Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT * FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor WHERE profesor.id_departamento IS NULL;
-- Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT * FROM departamento left JOIN profesor ON profesor.id_departamento = departamento.id WHERE profesor.id_departamento IS NULL;
-- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT * FROM persona LEFT JOIN asignatura ON persona.id = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL AND persona.tipo LIKE "profesor";
-- Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT * FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor WHERE asignatura.id_profesor IS NULL;
-- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
-- Retorna el nombre total d'alumnes que hi ha.
SELECT SUM(persona.id) AS nombre_total_alumnes FROM persona WHERE tipo LIKE "alumno";
-- Calcula quants alumnes van néixer en 1999.
SELECT SUM(persona.id) AS naixement_1999 FROM persona WHERE tipo LIKE "alumno" AND fecha_nacimiento LIKE "1999%";
-- Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT SUM(departamento.id)departamento FROM departamento GROUP BY departamento.id;
-- Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT departamento.*, SUM(profesor.id_departamento) AS nombre_professors FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.id;
-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT grado.*, SUM(asignatura.id_grado) FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.id ORDER BY SUM(asignatura.id_grado) DESC; 
-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
-- Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
-- Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
-- Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, SUM(asignatura.id_profesor) FROM persona LEFT JOIN asignatura ON persona.id = asignatura.id_profesor GROUP BY persona.id ORDER BY SUM(asignatura.id_profesor) DESC;
-- Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona ORDER BY persona.fecha_nacimiento DESC LIMIT 1;
-- Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.