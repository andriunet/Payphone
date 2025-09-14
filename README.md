# 📱 Payphone

Prueba práctica de iOS desarrollada en **SwiftUI + MVVM**, con integración de **Alamofire** para consumo de API, **Realm** para persistencia local y **Core Location** para obtener la ubicación del usuario.  

## Funcionalidades

- 📡 **Consumo de API**: lista de usuarios desde [JSONPlaceholder](https://jsonplaceholder.typicode.com/users).  
- 💾 **Persistencia local**: caché y almacenamiento offline con Realm.  
- 🌍 **Localización**: obtención de coordenadas y visualización en alertas.  
- 🌐 **Internacionalización**: soporte multilenguaje (Inglés/Español) con `Localizable.strings`.  
- ⚡ **Arquitectura limpia**: patrón **MVVM** para separar lógica y UI.  
- 🚨 **Manejo de errores**: alertas amigables con `AppError`.  

---

## Tecnologías utilizadas

- [SwiftUI](https://developer.apple.com/xcode/swiftui/) — UI declarativa moderna.  
- [Alamofire](https://github.com/Alamofire/Alamofire) — Networking y manejo de peticiones HTTP.  
- [Realm](https://realm.io/) — Base de datos local persistente.  
- [Core Location](https://developer.apple.com/documentation/corelocation) — Ubicación del usuario.  
- Async/Await y Combine para concurrencia reactiva.  

---

## Decisiones técnicas y priorización

Durante el desarrollo prioricé las implementaciones más críticas dentro del tiempo disponible:

- **Consumo de API y persistencia local con Realm** → asegurar datos aún sin conexión.  
- **Arquitectura MVVM** → separar lógica de negocio y UI, facilitando escalabilidad.  
- **Manejo de errores** → garantizar una experiencia estable ante fallos de red o validación.  

Otras funcionalidades como localización, internacionalización y mejoras visuales se implementaron de manera básica, dejando espacio para optimizarlas en futuras iteraciones.  


## Instalación

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/andriunet/Payphone.git
   cd Payphone


## Mejoras futuras

- Integrar búsqueda de usuario.
- Mejor manejo de errores de red: mostrar mensajes más amigables con opción de reintentar.
- Soporte Dark Mode: adaptar la UI para que se vea correctamente en claro/oscuro.


## iPhone

<table>
<tbody>
<tr>
<td><img src="https://github.com/andriunet/Payphone/blob/main/screen/1.png"/></td>
<td><img src="https://github.com/andriunet/Payphone/blob/main/screen/2.png"/></td>
<td><img src="https://github.com/andriunet/Payphone/blob/main/screen/3.png"/></td>
</tr>
<tr>
  <td><img src="https://github.com/andriunet/Payphone/blob/main/screen/4.png"/></td>
  <td><img src="https://github.com/andriunet/Payphone/blob/main/screen/5.png"/></td>
</tr>
</tbody>
</table>
