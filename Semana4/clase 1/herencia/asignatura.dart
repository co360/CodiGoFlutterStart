import 'alumno.dart';
import 'persona.dart';
import 'profesor.dart';

class Asignatura {
  String nombre;
  Persona profesor;
  List<Alumno> alumnos = [];

  Asignatura({this.nombre, this.profesor, this.alumnos});

  @override
  String toString() {
    return nombre + ": " + profesor.toString();
  }

  void agregarAlumno(Alumno a) {
    if (alumnos == null) {
      alumnos = [];
      alumnos.add(a);
    }
  }

  Asignatura operator +(Alumno a) {
    if (alumnos == null) {
      alumnos = [];
    }
    alumnos.add(a);
    // se devuelve this porque esta devolviendose a si misma, solo que con alumnos llenados
    return this;
  }

  Alumno operator [](int i) {
    return alumnos[i];
  }
}
