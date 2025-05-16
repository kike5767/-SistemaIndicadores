-- CREACION BASE DE DATOS SISTEMAINDICADORES

CREATE DATABASE SISTEMAINDICADORES
GO

USE SISTEMAINDICADORES
GO


CREATE TABLE actor (
  id varchar(50) NOT NULL PRIMARY KEY,
  nombre varchar(200) NOT NULL,
  fkidtipoactor int NOT NULL
);


-- --------------------------------------------------------
-- ✅ Estructura de tabla para almacenar cálculos de indicadores
-- --------------------------------------------------------

CREATE TABLE calculoindicadores (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- 🔹 Identificador único autoincremental
    fkidindicador INT NOT NULL, -- 🔹 Referencia al indicador
    resultado DECIMAL(18,2) NOT NULL, -- 🔹 Valor del cálculo
    fechacalculo DATETIME NOT NULL DEFAULT GETDATE(), -- 🔹 Fecha de cálculo
    observaciones NVARCHAR(255), -- 🔹 Notas adicionales
    
    -- 🔹 Restricción de clave foránea vinculando con la tabla `indicador`
    CONSTRAINT FK_calculo_indicador FOREIGN KEY (fkidindicador) REFERENCES indicador(id) ON DELETE CASCADE ON UPDATE NO ACTION
);

-- ✅ Índice para mejorar el rendimiento en búsquedas por `fkidindicador`
CREATE INDEX IDX_CalculoIndicadores_Indicador ON calculoindicadores(fkidindicador);

-- ✅ Volcado de datos de prueba
INSERT INTO calculoindicadores (fkidindicador, resultado, fechacalculo, observaciones) VALUES
(30, 95.50, '2025-05-09 08:00:00', 'Cálculo inicial sobre el indicador 30'),
(31, 88.75, '2025-05-09 08:15:00', 'Cálculo ajustado para el indicador 31');



--
-- Volcado de datos para la tabla actor
--

INSERT INTO actor (id, nombre, fkidtipoactor) VALUES
('1', 'Hugo', 1),
('1234567', '1234567', 3),
('17', 'Para Borar', 1),
('2', 'Paco', 1),
('3', 'Luís', 1),
('300002023', 'Carlos Arturo Castro Castro', 2),
('71665', 'Carlos Castro', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla articulo
--

CREATE TABLE articulo (
  id varchar(20) NOT NULL PRIMARY KEY,
  nombre varchar(1000) NOT NULL,
  descripcion varchar(4000) NOT NULL,
  fkidseccion varchar(2) NOT NULL,
  fkidsubseccion varchar(2) NOT NULL
);

--
-- Volcado de datos para la tabla articulo
--

INSERT INTO articulo (id, nombre, descripcion, fkidseccion, fkidsubseccion) VALUES
('0', 'NA', 'NA', '0', '0'),
('2.5.3.2.1.1', 'Concepto de calidad', 'Es el conjunto de atributos articulados, interdependientes, dinámicos, construidos por la comunidad académica como referentes y que responden a las demandas sociales, culturales y ambientales. Dichos atributos permiten hacer valoraciones internas y externas a las instituciones, con el fin de promover su transformación y el desarrollo permanente de sus labores formativas, académicas, docentes, científicas, culturales y de extensión', '1', '0'),
('2.5.3.2.1.2', 'Sistema de Aseguramiento de la Calidad de la Educación Superior', 'Es el conjunto de instituciones e instancias definidas por el marco normativo vigente, que se articulan por medio de políticas y procesos diseñados, con el propósito de asegurar la calidad de las instituciones y de sus programas. Este sistema promueve en las instituciones los procesos de autoevaluación, autorregulación y mejoramiento de sus labores formativas, académicas, docentes, científicas, culturales y de extensión, contribuyendo al avance y fortalecimiento de su comunidad y sus resultados académicos, bajo principios de equidad, diversidad, inclusión y sostenibilidad', '1', '0'),
('2.5.3.2.1.3', 'Actores del Sistema de Aseguramiento de la Calidad de la Educación Superior', 'Son Actores del Sistema de Aseguramiento de la Calidad de la Educación Superior: ', '1', '0'),
('2.5.3.2.10.1', 'Renovación del registro calificado de programa', 'La renovación del registro calificado debe ser solicitada por las instituciones con no menos de 12 meses de anticipación a la fecha de vencimiento del respectivo registro. \\r\\nCuando el Ministerio de Educación Nacional resuelva no renovar el registro calificado o la institución decida no adelantar el proceso de renovación de registro calificado, la institución deberá garantizar a las cohortes iniciadas durante la vigencia del registro calificado del programa, la culminación del correspondiente programa en las condiciones que dieron lugar al otorgamiento del registro. Para el efecto, la institución deberá establecer y ejecutar un plan de contingencia, que prevea el seguimiento por parte del Ministerio de Educación Nacional, así como estrategias para garantizar la permanencia y continuidad de las cohortes ya iniciadas. \\r\\nPara ello, dentro de los 2 meses siguientes, contados a partir de la fecha de ejecutoria del acto administrativo por medio del cual se niegue la renovación del registro calificado o vencida la vigencia del registro calificado que no fue objeto de solicitud de renovación, la institución deberá radicar dicho plan de contingencia ante la Subdirección de Apoyo a la Gestión de Instituciones de Educación Superior del Ministerio de Educación Nacional, o la dependencia que haga sus veces', '10', '0'),
('2.5.3.2.10.2', 'Modificaciones del programa', 'Cualquier modificación que afecte las condiciones de calidad del programa con las cuales se le otorgó el registro calificado al mismo, debe informarse al Ministerio de Educación Nacional a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces. Dicha modificación se incorporará al respectivo registro calificado para mantenerlo actualizado. \\r\\nLas modificaciones que afectan las condiciones de calidad del programa que requerirán aprobación previa y expresa del Ministerio de Educación Nacional serán las que conciernen a los siguientes aspectos: Para tal efecto, el representante legal o apoderado de la institución, con una antelación de 12 meses a la expiración del registro calificado, hará llegar al Ministerio de Educación Nacional la respectiva solicitud a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces, junto con la debida justificación y los soportes documentales que evidencien su aprobación por el órgano competente de la institución, acompañado de un régimen de transición que garantice los derechos de los estudiantes, cuando aplique o corresponda. \\r\\nUna vez surtido este trámite, el Ministerio de Educación Nacional procederá a resolver la solicitud realizada por la institución conforme con el trámite establecido en el presente capítulo y demás normas concordantes o que lo desarrollen', '10', '0'),
('2.5.3.2.10.3', 'Solicitudes de renovación y modificación de registro calificado', 'uando se presenten simultáneamente solicitudes de renovación y modificación del registro calificado, y no se aprueben las modificaciones, pero proceda la renovación, el Ministerio de Educación Nacional otorgará la renovación en los términos del registro calificado vigente. ', '10', '0'),
('2.5.3.2.10.4', 'Ampliación del lugar de desarrollo', 'La institución podrá solicitar la ampliación del lugar de desarrollo de los programas con registro calificado a otro u otros municipios del o de los inicialmente aprobados, siempre que el programa mantenga las condiciones de denominación, aspectos curriculares, y organización de actividades académicas y proceso formativo del programa que se pretende ampliar. La ampliación del lugar de desarrollo no modifica el término de vigencia del registro calificado del programa ampliado. \\r\\nLa solicitud de ampliación del lugar de desarrollo se tramitará como una modificación de registro calificado, para lo cual se surtirá lo dispuesto en el artículo 2.5.3.2.10.2. del presente decreto y puede ser presentada hasta con doce (12) meses antes del vencimiento del registro calificado del programa que se pretende ampliar. \\r\\nPara cada lugar de desarrollo ampliado se deberá llevar a cabo la visita de el (los) par(es) y contar con el concepto favorable de condiciones institucionales por parte de la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces), conforme el artículo 2.5.3.2.8.1.6. y siguientes del presente decreto. \\r\\nEn caso de que, para ese lugar de desarrollo, previo a la solicitud de registro calificado, se cuente con el concepto favorable de las condiciones institucionales, no se requiere proceso de evaluación de dichas condiciones', '10', '0'),
('2.5.3.2.10.5', 'Del cumplimiento de las condiciones de calidad de programa por parte de las instituciones y entidades habilitadas por ley para ofrecer programas de educación superior', 'Las instituciones y entidades enunciadas en el artículo 137 de la Ley 30 de 1992, así como las demás habilitadas por ley para ofrecer y desarrollar programas de educación superior, forman parte del Sistema de Aseguramiento de la Calidad de la Educación Superior y por ende, continuarán dando cumplimiento a las disposiciones contenidas en la Ley 1188 de 2008, en coherencia con las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), los niveles de formación, su naturaleza jurídica, tipología, identidad y misión institucional. ', '10', '0'),
('2.5.3.2.11.1', 'Programas activos e inactivos', 'Se entenderá por programa académico de educación superior con registro activo aquel que cuenta con el reconocimiento del Estado sobre el cumplimiento de las condiciones de calidad, mediante registro calificado vigente. \\r\\nPor programa académico de educación superior con registro calificado inactivo, se entenderá aquel respecto del cual la institución no cuenta con registro calificado vigente, y que en consecuencia de lo anterior no podrá admitir nuevos estudiantes, pero deberá seguir funcionando hasta culminar las cohortes que iniciaron durante la vigencia del registro calificado, desarrollándolo en las condiciones de calidad adecuadas. \\r\\nLa inactivación del registro de los programas académicos puede operar por solicitud de la institución o por expiración del término del registro calificado', '11', '0'),
('2.5.3.2.11.2', 'Publicidad y oferta de programas', 'Las instituciones solamente podrán hacer publicidad y ofrecer los programas académicos, una vez obtengan el registro calificado y durante su vigencia. \\r\\nLa oferta y publicidad de los programas académicos activos debe ser clara, veraz y corresponder con la información registrada en el Sistema Nacional de Información de la Educación Superior (SNIES) e incluir el código asignado, y señalar que se trata de una institución sujeta a inspección y vigilancia por el Ministerio de Educación Nacional', '11', '0'),
('2.5.3.2.11.3', 'Expiración del registro', 'Expirada la vigencia del registro calificado, la institución no podrá admitir nuevos estudiantes para tal programa y deberá garantizar a las cohortes iniciadas la culminación del correspondiente programa en condiciones de calidad', '11', '0'),
('2.5.3.2.11.4', 'De la inspección y vigilancia', 'El Ministerio de Educación Nacional podrá adelantar en cualquier momento la verificación de las condiciones de calidad bajo las cuales se ofrece y desarrolla un programa académico de educación superior acorde con la normatividad vigente', '11', '0'),
('2.5.3.2.11.5', 'Protección de datos', 'Tanto el Ministerio de Educación Nacional como las instituciones deberán implementar todos los protocolos y garantías del derecho a la protección de datos personales según lo dispuesto en la Ley 1581 de 2012, “por la cual se dictan disposiciones generales para la protección de datos personales” o la norma que la modifique, sustituya o derogue, así como las normas que la desarrollen y complementen. \\r\\nEn caso de tener conocimiento de posibles vulneraciones a dicho derecho, los hechos deberán ser puestos en conocimiento de la autoridad competente', '11', '0'),
('2.5.3.2.11.6', 'Pares académicos', 'Son personas idóneas, reconocidas por sus características académicas y/o profesionales, íntegras y éticas en su quehacer con un amplio conocimiento de la educación superior; que, por medio de una mirada valorativa, verifican las condiciones institucionales y de programa de forma objetiva fruto de su experiencia. Dicha mirada se fundamenta en el proceso de autoevaluación de la institución y en los protocolos que para tal fin definirá el Ministerio de Educación Nacional', '11', '0'),
('2.5.3.2.11.7', 'Régimen de inhabilidades, incompatibilidades y conflicto de intereses', 'Los pares académicos y los integrantes de las salas de la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces) son particulares en ejercicio de funciones administrativas, por tal razón se encuentran sujetos al régimen de inhabilidades, incompatibilidades y conflicto de intereses dispuesto por la Constitución y la ley. \\r\\nLas decisiones relacionadas con impedimentos y recusaciones serán resueltas por el Ministerio de Educación Nacional y, cuando a ello haya lugar, designará nuevos pares en el término de cinco (5) días calendario y comunicará su determinación a la institución a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES)', '11', '0'),
('2.5.3.2.11.8', 'Banco de Pares Académicos', 'El Ministerio de Educación Nacional actualizará el Banco de Pares, siguiendo un procedimiento de convocatoria pública, la cual se desarrollará en el término de un año, contado desde la entrada en vigencia de la presente modificación. \\r\\nUna vez conformado el Banco de Pares Académicos, las hojas de vida de sus integrantes estarán disponibles para consulta en el Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces, conforme con la normatividad sobre protección de datos personales que se encuentre vigente', '11', '0'),
('2.5.3.2.12.1', 'Vigencia temporal de condiciones institucionales', 'Para aquellas instituciones que, entre el 1° de enero de 2018 y la fecha de entrada en vigencia de la presente modificación, hayan obtenido 2 o más registros calificados o su renovación o que hayan obtenido personería jurídica o cambio de carácter académico, se entenderá surtida la etapa de prerradicación de registro calificado dispuesta en los artículos 2.5.3.2.8.1.1. y siguientes, por dos (2) años contados a partir de la entrada en vigencia de la presente modificación normativa. \\r\\nPara aquellas instituciones que en el mismo periodo, cuenten con un porcentaje de programas acreditados mayor o igual al 10%, del total de programas acreditables; se entenderá surtida la etapa de prerradicación de registro calificado, con una vigencia de 3 años contados a partir de la entrada en vigencia de la presente modificación', '12', '0'),
('2.5.3.2.12.2', 'Extensión de vigencia de registros calificados', 'Aquellos programas de educación superior que cuenten con registro calificado que venza entre el 1° de junio de 2020 y el 31 de diciembre de 2020, se entenderá extendida su vigencia automáticamente durante dieciocho (18) meses más. \\r\\nAquellos programas de educación superior que cuenten con registro calificado que venza entre el 1° de enero de 2021 y el 30 de junio de 2021, se entenderá extendida su vigencia automáticamente durante 12 meses', '12', '0'),
('2.5.3.2.2.1', 'Definición', 'El registro calificado es un requisito obligatorio y habilitante para que una institución de educación superior, legalmente reconocida por el Ministerio de Educación Nacional, y aquellas habilitadas por la ley, pueda ofrecer y desarrollar programas académicos de educación superior en el territorio nacional, de conformidad con lo dispuesto en el artículo 1° de la Ley 1188 de 2008. \\r\\nEl registro calificado del programa académico de educación superior es el instrumento del Sistema de Aseguramiento de la Calidad de la Educación Superior mediante el cual el Estado verifica y evalúa el cumplimiento de las condiciones de calidad por parte de las instituciones de educación superior y aquellas habilitadas por la ley. \\r\\nLas condiciones de calidad hacen referencia a las condiciones institucionales y de programa', '2', '0'),
('2.5.3.2.2.2', 'Otorgamiento y vigencia del registro calificado', 'El registro calificado será otorgado por el Ministerio de Educación Nacional mediante acto administrativo motivado en el cual se ordenará la inscripción, modificación o renovación del programa en el Sistema Nacional de Información de Educación Superior (SNIES) cuando proceda. \\r\\nEl registro calificado tendrá una vigencia de 7 años, contados a partir de la fecha de ejecutoria del respectivo acto administrativo y ampara las cohortes iniciadas durante su vigencia', '2', '0'),
('2.5.3.2.2.3', 'Carencia de registro calificado', '. Se presenta ante la inexistencia del registro calificado otorgado por el Ministerio de Educación Nacional para que una institución pueda ofrecer un programa académico de educación superior. \\r\\nNo constituye título de carácter académico de educación superior aquel que otorgue una institución respecto de un programa que carezca de registro calificado o acreditación en alta calidad. Lo anterior, en concordancia con lo dispuesto respecto de los programas activos e inactivos en el artículo 2.5.3.2.11.1 del presente decreto', '2', '0'),
('2.5.3.2.2.4', 'Registro calificado único', 'El registro calificado único podrá ser solicitado por las instituciones, cuando frente a un programa pretendan implementar diversas modalidades y/o ofrecerlo en diferentes municipios. \\r\\nLas instituciones que deseen ofrecer un programa académico con idéntico contenido curricular, mediante distintas modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), podrán solicitar un registro calificado único, siempre y cuando las condiciones de calidad estén garantizadas para la(s) modalidad(es) que pretenda desarrollar, en coherencia con la naturaleza jurídica, tipología, identidad y misión institucional. \\r\\nEn el caso de que la solicitud incluya dos (2) o más municipios, en los que se ofertará el programa, se otorgará un único registro y la propuesta debe hacer explícitas las condiciones de calidad de este en cada uno de los municipios, atendiendo al contexto y las posibilidades de la región. \\r\\nLo anterior, con el propósito de incentivar la flexibilidad, movilidad, regionalización y el desarrollo de rutas de aprendizaje en condiciones diversas de tiempo y espacio', '2', '0'),
('2.5.3.2.2.5', 'Definición de modalidad', 'Es el modo utilizado que integra un conjunto de opciones organizativas y/o curriculares que buscan dar respuesta a requerimientos específicos del nivel de formación y atender características conceptuales que faciliten el acceso a los estudiantes, en condiciones diversas de tiempo y espacio', '2', '0'),
('2.5.3.2.2.6', 'Definición de metodología', 'Es un conjunto de estrategias educativas, métodos y técnicas estructuradas y organizadas para posibilitar el aprendizaje de los estudiantes dentro del proceso formativo', '2', '0'),
('2.5.3.2.3.1.1', 'Conceptualización', 'Son las características necesarias a nivel institucional que facilitan y promueven el desarrollo de las labores formativas, académicas, docentes, científicas, culturales y de extensión de las instituciones en coherencia con su naturaleza jurídica, tipología, identidad y misión institucional, así como de las distintas modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), de los programas que oferta, en procura del fortalecimiento integral de la institución y la comunidad académica, todo lo anterior en el marco de la transparencia y la gobernabilidad. \\r\\nEn cumplimiento de lo dispuesto en el artículo 2° de la Ley 1188 de 2008, las instituciones deberán cumplir con las siguientes condiciones de calidad de carácter institucional: mecanismos de selección y evaluación de estudiantes y profesores, estructura administrativa y académica, cultura de la autoevaluación, programa de egresados, modelo de bienestar y recursos suficientes para garantizar el cumplimiento de las metas', '3', '13'),
('2.5.3.2.3.1.2', 'Mecanismos de selección y evaluación de estudiantes y profesores', 'La institución demostrará la existencia, implementación y divulgación de políticas institucionales, reglamento profesoral y reglamento estudiantil o sus equivalentes en los que se adopten mecanismos y criterios para la selección, permanencia, promoción y evaluación de los profesores y de los estudiantes, con sujeción a lo previsto en la Constitución y la ley. Tales documentos deben estar dispuestos en los medios de comunicación e información institucional', '3', '13'),
('2.5.3.2.3.1.3', 'Estructura administrativa y académica', 'Es el conjunto de políticas, relaciones, procesos, cargos, actividades e información, necesarias para desplegar las funciones propias de una institución de educación superior, la cual deberá demostrar que cuenta por lo menos con: ', '3', '13'),
('2.5.3.2.3.1.4', 'Cultura de la autoevaluación', 'Es el conjunto de mecanismos que las instituciones tienen para el seguimiento sistemático del cumplimiento de sus objetivos misionales, el análisis de las condiciones que afectan su desarrollo, y las medidas para el mejoramiento continuo. Esta cultura busca garantizar que la oferta y desarrollo de programas académicos se realice en condiciones de calidad y que las instituciones rindan cuentas ante la comunidad, la sociedad y el Estado sobre el servicio educativo que presta La institución deberá demostrar la existencia, divulgación, e implementación de políticas institucionales que promuevan la autoevaluación, la autorregulación, y el mejoramiento de acuerdo con su naturaleza jurídica, tipología, identidad y misión institucional, para generar una corresponsabilidad de toda la comunidad académica en el mejoramiento continuo. \\r\\nLa institución deberá contar con un sistema interno de aseguramiento de la calidad que contemple, al menos, lo siguiente: ', '3', '13'),
('2.5.3.2.3.1.5', 'Programa de egresados', 'Los egresados evidencian la apropiación de la misión institucional, por lo tanto, son ellos quienes a través de su desarrollo profesional y personal contribuyen a las dinámicas sociales y culturales. Por tal razón, la institución deberá demostrar la existencia, divulgación e implementación de los resultados de políticas, planes y programas que promuevan el seguimiento a la actividad profesional de los egresados. A su vez, la institución deberá establecer mecanismos que propendan por el aprendizaje a lo largo de la vida, de tal forma que involucre la experiencia del egresado en la dinámica institucional', '3', '13'),
('2.5.3.2.3.1.6', 'Modelo de bienestar', 'La institución establecerá las políticas, procesos, actividades y espacios que complementan y fortalecen la vida académica y administrativa, con el fin de facilitarle a la comunidad institucional el desarrollo integral de la persona y la convivencia en coherencia con las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), los niveles de formación, su naturaleza jurídica, tipología, identidad y misión institucional. \\r\\nEn coherencia con lo anterior, la institución deberá demostrar la existencia de mecanismos de divulgación e implementación de los programas de bienestar orientados a la prevención de la deserción y a la promoción de la graduación de los estudiantes', '3', '13'),
('2.5.3.2.3.1.7', 'Recursos suficientes para garantizar el cumplimiento de las metas', 'Se refiere a la existencia, gestión y dotación de los recursos tangibles e intangibles que le permiten desarrollar a la institución sus labores formativas, académicas, docentes, científicas, culturales y de extensión. Para tal fin, la institución deberá definir su misión, propósitos y objetivos institucionales, los cuales orientarán los requerimientos de talento humano, recursos físicos, tecnológicos y financieros, en coherencia con las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), los niveles de formación, su naturaleza jurídica, tipología, identidad y misión institucional. \\r\\nLa institución deberá dar cuenta de: ', '3', '13'),
('2.5.3.2.3.1.8', 'Evaluación de condiciones institucionales', 'En cada uno de los lugares de desarrollo, para obtener, modificar o renovar un registro calificado se requiere cumplir con las condiciones de calidad institucionales en coherencia con su naturaleza jurídica, tipología, identidad y misión institucional. La evaluación de las condiciones de calidad institucionales será una etapa previa a la presentación de las solicitudes de registro calificado para los programas académicos y tendrá una vigencia de 7 años.', '3', '13'),
('2.5.3.2.3.1.9', 'Renovación de condiciones institucionales', 'Se deberá evidenciar el mejoramiento proveniente de los ejercicios de autoevaluación y autorregulación en concordancia con su sistema de aseguramiento de la calidad. La institución deberá tener disponibles los datos comparados de los procesos de autoevaluación y las evidencias del mejoramiento presentado en las condiciones institucionales del registro calificado', '3', '13'),
('2.5.3.2.3.2.1', 'Conceptualización', 'Las condiciones de programa se entenderán como las características necesarias por nivel que describen sus particularidades en coherencia con la tipología, identidad y misión institucional, así como de las distintas modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades). Las condiciones de programa son: denominación; justificación; aspectos curriculares; organización de actividades académicas y proceso formativo; investigación, innovación y/o creación artística y cultural; relación con el sector externo; profesores; medios educativos e infraestructura física y tecnológica', '3', '23'),
('2.5.3.2.3.2.10', 'Infraestructura física y tecnológica', 'La institución proveerá los ambientes físicos y virtuales de aprendizaje, específicos para el desarrollo de los procesos formativos, la investigación y la extensión de acuerdo con las modalidades en que el programa se ofrezca', '3', '23'),
('2.5.3.2.3.2.11', 'Evaluación de condiciones de programa', 'El cumplimiento de las condiciones de programa descritas en el presente Decreto es condición necesaria para obtener, modificar o renovar un registro calificado, lo cual deberá ser coherente con la(s) modalidad(es) (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades) en la que será o es ofrecido, su nivel de formación, así como, la naturaleza jurídica, tipología e identidad institucional. ', '3', '23'),
('2.5.3.2.3.2.12', 'Renovación del registro calificado', 'Para su solicitud, las instituciones, soportadas en su sistema interno de aseguramiento de la calidad, evidenciarán el mejoramiento con referencia a las condiciones del programa, evaluadas en el proceso de registro calificado o de renovación anterior. \\r\\nEn caso de la existencia de medios educativos a través de convenios o contratos, el programa deberá evidenciar la implementación y la ejecución de los mismos y su respectiva renovación en caso de ser necesario, incluyendo, en las cláusulas, los alcances de la disponibilidad en términos de horarios y capacidad', '3', '23'),
('2.5.3.2.3.2.2', 'Denominación del programa', 'La institución deberá especificar la denominación o nombre del programa, en correspondencia con el título que se va a otorgar, el nivel de formación, los contenidos curriculares del programa y el perfil del egresado; lo anterior de acuerdo con la normatividad vigente. \\r\\nLos programas técnicos profesionales y tecnológicos deben adoptar denominaciones que correspondan con las competencias propias de su campo de conocimiento, de tal manera que su denominación sea diferenciable y permita una clara distinción de las ocupaciones, disciplinas y profesiones. \\r\\nLos programas de especialización deben definir denominaciones que correspondan al área específica de estudio. En el caso de los programas de maestría y doctorado podrán adoptar una denominación disciplinar o interdisciplinar', '3', '23'),
('2.5.3.2.3.2.3', 'Justificación del programa', 'La institución deberá presentar una justificación que sustente el contenido curricular, los perfiles de egreso y la(s) modalidad(es), en que se desea ofrecer el programa para que este sea pertinente al desarrollo social, cultural, ambiental, económico y científico, frente a las necesidades del país y la región, con fundamento en un estudio que por lo menos contenga los siguientes componentes: ', '3', '23'),
('2.5.3.2.3.2.4', 'Aspectos curriculares', 'La institución deberá diseñar el contenido curricular del programa según el área de conocimiento y en coherencia con las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), los niveles de formación, su naturaleza jurídica, tipología e identidad institucional. El cual deberá contar, por lo menos con: ', '3', '23'),
('2.5.3.2.3.2.5', 'Organización de actividades académicas y proceso formativo', 'La institución deberá establecer en el programa, la organización de las actividades y la interacción de las mismas, de acuerdo con el diseño y contenido curricular, en coherencia con las modalidades, los niveles de formación, la naturaleza jurídica, la tipología y la identidad institucional. Para cada actividad de formación incluida en el plan de estudios se deben presentar los créditos y discriminar las horas de trabajo independiente y las de acompañamiento directo del docente, acorde con el sistema institucional de créditos', '3', '23'),
('2.5.3.2.3.2.6', 'Investigación, innovación y/o creación artística y cultural', ' La institución deberá establecer en el programa las estrategias para la formación en investigación-creación que le permitan a profesores y estudiantes estar en contacto con los desarrollos disciplinarios e interdisciplinarios, la creación artística, los avances tecnológicos y el campo disciplinar más actualizado, de tal forma que se desarrolle el pensamiento crítico y/o creativo. \\r\\nEl programa en coherencia con el nivel de formación, las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), con la naturaleza jurídica, tipología, identidad y misión institucional, propenderá a que sus resultados de investigación contribuyan a la transformación social de las dinámicas que aporten a la construcción del país. \\r\\nSegún la declaración explícita que realice el programa con relación a la incorporación de la investigación para el desarrollo del conocimiento, el programa deberá definir las áreas, líneas o temáticas de investigación en las que se enfocarán los esfuerzos y proyectos. Lo anterior, teniendo en cuenta los siguientes propósitos de investigación: ', '3', '23'),
('2.5.3.2.3.2.7', 'Relación con el sector externo', 'La institución deberá establecer para el programa, los mecanismos y estrategias para lograr la vinculación de la comunidad y el sector productivo, social, cultural, público y privado, en coherencia con las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), el nivel de formación del programa, la naturaleza jurídica de la institución, la tipología e identidad institucional. \\r\\nEn coherencia con el proceso formativo y la investigación, el programa establecerá los mecanismos y las estrategias, para lograr la articulación de los profesores y estudiantes con la dinámica social, productiva, creativa y cultural de su contexto. ', '3', '23'),
('2.5.3.2.3.2.8', 'Profesores', 'La institución deberá especificar para el programa un grupo de profesores que, en número, desarrollo pedagógico, nivel de formación, experiencia laboral, vinculación y dedicación, le permitan atender adecuadamente el proceso formativo, las funciones de docencia, investigación y extensión, en coherencia con las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), el nivel de formación del programa, la naturaleza jurídica de la institución, la tipología e identidad institucional. \\r\\nPara esto, la institución deberá evidenciar en su programa, por lo menos, lo siguiente: una estrategia para la vinculación, permanencia y desarrollo de los profesores, que contemple referentes con relación al título académico e idoneidad, formación profesional y pedagógica, experiencia profesional, investigación y/o creación artística, acordes con el nivel de formación del programa, la(s) modalidad(es) y las actividades bajo su responsabilidad. \\r\\nCuando se trate de programas técnicos profesionales, tecnológicos y programas en las áreas de conocimiento de arte y cultura, en cualquier nivel y modalidad, se admitirán de manera excepcional, certificaciones de cualificación en actividades asociadas a las labores formativas, académicas, docentes, científicas, culturales y de extensión a desarrollar y la experiencia laboral certificada', '3', '23'),
('2.5.3.2.3.2.9', 'Medios educativos', 'La institución deberá contar con la dotación de los ambientes físicos y/o virtuales de aprendizaje que incorporan equipos, mobiliario, plataformas tecnológicas, sistemas informáticos o los que hagan sus veces, recursos bibliográficos, físicos y digitales, bases de datos, recursos de aprendizaje e información, entre otros, que atienden los procesos formativos, el desarrollo de la investigación y la extensión. \\r\\nLa institución deberá contar con mecanismos de capacitación y apropiación de los medios educativos para los estudiantes y profesores que estén adscritos al programa, así como evidenciar un plan de mantenimiento, actualización y reposición de los medios educativos. \\r\\nLa institución deberá contar con la disponibilidad de los medios educativos para cada modalidad (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades) estableciendo estrategias que atiendan las barreras de acceso y las características de la población', '3', '23'),
('2.5.3.2.4.1', 'Crédito académico', 'Es la unidad de medida del trabajo académico del estudiante que indica el esfuerzo a realizar para alcanzar los resultados de aprendizaje previstos. El crédito equivale a cuarenta y ocho (48) horas para un periodo académico y las instituciones deberán determinar la proporción entre la relación directa con el profesor y la práctica independiente del estudiante, justificado de acuerdo con el proceso formativo y los resultados de aprendizaje previstos para el programa. \\r\\nLas instituciones deberán expresar en créditos académicos de todas las actividades de formación que estén incluidas en el plan de estudios', '4', '0'),
('2.5.3.2.4.2', 'Número de créditos académicos del proceso formativo', 'El número de créditos de una actividad académica en el plan de estudios será aquel que resulte de dividir en cuarenta y ocho (48) el número total de horas que debe emplear el estudiante para cumplir satisfactoriamente las metas de aprendizaje, en un periodo académico. Para los efectos de este capítulo, el número de créditos de una actividad académica será expresado siempre en números enteros', '4', '0'),
('2.5.3.2.4.3', 'Horas de acompañamiento y de trabajo independiente', 'Para establecer el número de créditos del programa, atendiendo a la(s) modalidad(es), el nivel y la(s) metodología(s), la institución deberá demostrar la existencia de los lineamientos institucionales aplicados para discriminar las horas de trabajo independiente y las de acompañamiento directo del docente, que permitan evidenciar, entre otros, los resultados de aprendizaje previstos y las posibilidades de movilidad nacional e internacional de los estudiantes. \\r\\nLos programas del área de ciencias de la salud deben prever las prácticas formativas, supervisadas por profesores responsables de ellas y disponer de los escenarios apropiados para su realización, y estarán sujetos a lo dispuesto en este Decreto, en concordancia con la normatividad vigente, el modelo de evaluación de la relación docencia servicio y demás normas sobre la materia', '4', '0'),
('2.5.3.2.5.1', 'Programas en Convenio', 'Podrán ser ofrecidos y desarrollados programas académicos en virtud de convenios celebrados con tal finalidad, de conformidad con las disposiciones vigentes. \\r\\nLas instituciones podrán, de manera conjunta, desarrollar programas académicos mediante convenio entre ellas, o con instituciones de educación superior extranjeras, legalmente reconocidas en el país de origen por la autoridad competente. Para la formación avanzada de programas de maestría y doctorado podrán celebrarse convenios con institutos o centros de investigación, reconocidos por la instancia nacional o internacional que corresponda. El alcance de los convenios con instituciones de educación superior, institutos o centros de investigación extranjeras debe ser informado al estudiante. \\r\\nEn el caso de convenios entre instituciones colombianas, la titularidad del correspondiente registro calificado, el lugar de desarrollo del programa y las responsabilidades académicas y de titulación, serán aspectos que deberán ser regulados entre las partes en cada convenio. \\r\\nEn el caso de convenios entre instituciones colombianas con instituciones extranjeras la titularidad del correspondiente registro calificado, el lugar de desarrollo del programa y las responsabilidades académicas y de titulación, serán aspectos que recaerán en la institución colombiana. \\r\\nLo anterior tendrá como propósito, entre otros, promover la colaboración académica, la movilidad internacional, la doble titulación, la titulación conjunta y las co-tutelas de tesis, en coherencia con la naturaleza jurídica, identidad, tipología de la institución y nivel de formación del programa. Todo esto debe ser informado en debida forma a los estudiantes y docentes del programa, así como los mecanismos y procedimientos para la ejecución de los convenios; en el supuesto de que la institución extranjera que haga parte del convenio otorgue un título, este se regirá por la normatividad del país correspondiente y para ser reconocida en Colombia deberá surtir el trámite de convalidación, según la normatividad vigente', '5', '0'),
('2.5.3.2.5.2', 'Registro de los programas en Convenio', 'Para obtener, renovar o modificar un registro calificado de un programa que se desarrolla en convenio, los representantes legales o apoderados de las instituciones que sean parte del convenio presentarán una única solicitud de registro calificado, a la cual adjuntarán, adicionalmente a los demás requisitos establecidos, el respectivo convenio. \\r\\nCuando sea procedente otorgar el registro calificado al programa, el Ministerio de Educación Nacional registrará en el Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces, su titularidad atendiendo la disposición correspondiente establecida por las instituciones en el respectivo convenio', '5', '0'),
('2.5.3.2.5.3', 'Titulación', 'La titulación es competencia exclusiva de las instituciones colombianas, a quienes se les haya otorgado el registro calificado del programa. No obstante, en el título se podrá mencionar a las demás instituciones participantes. \\r\\nParágrafo. Solamente estarán autorizadas para realizar la publicidad del programa académico en convenio, la(s) institución(es) que hacen parte del mismo, una vez obtengan el respectivo registro calificado', '5', '0'),
('2.5.3.2.5.4', 'De los convenios para ofrecer y desarrollar programas', 'Cuando un programa académico vaya a ser ofrecido en convenio por dos o más instituciones, dicho convenio deberá incluir las cláusulas que garanticen las condiciones de calidad para la obtención o renovación del registro calificado y los derechos de la comunidad hacia la cual va dirigido, en coherencia con las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), con su naturaleza jurídica, tipología, identidad y misión institucional. \\r\\nEn consecuencia, el convenio deberá estar vigente en un plazo no menor a la vigencia del registro calificado y contemplar al menos lo siguiente: ', '5', '0'),
('2.5.3.2.6.1', 'Programas de posgrado', 'Se trata de la formación posterior al título de pregrado que se desarrolla según el marco normativo vigente, en los niveles de especialización, maestría y doctorado', '6', '0'),
('2.5.3.2.6.2', 'Objetivos generales de los posgrados', 'Los programas de posgrado deben definir sus objetivos propios, en coherencia con las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), con su naturaleza jurídica, tipología, identidad y misión institucional. Estos objetivos deben estar orientados al desarrollo, entre otros, de: ', '6', '0'),
('2.5.3.2.6.3', 'Programas de especialización', 'Estos programas tienen como propósito la profundización en los saberes propios de un área de la ocupación, disciplina o profesión de que se trate, orientado a una mayor cualificación para el desempeño profesional y laboral. Las instituciones podrán ofrecer programas de especialización técnica profesional, tecnológica o profesional universitaria, de acuerdo con su carácter académico', '6', '0'),
('2.5.3.2.6.4', 'Programas de maestría', 'Los programas de maestría tienen como propósito ampliar y desarrollar los conocimientos, actitudes y habilidades para la solución de problemas disciplinares, interdisciplinarios o profesionales y/o dotar a la persona de los instrumentos básicos que la habilitan como investigador. Para cumplir con dicho propósito, según la normatividad vigente, los programas de maestría podrán ser de profundización o investigación. \\r\\nLa maestría de profundización será aquella que propenda por el desarrollo avanzado de conocimientos, actitudes y habilidades que permitan la solución de problemas o el análisis de situaciones particulares de carácter disciplinar, interdisciplinario o profesional, por medio de la asimilación o apropiación de saberes, metodologías y, según el caso, desarrollos científicos, tecnológicos, artísticos o culturales. Para optar al título del programa de maestría en profundización, el estudiante podrá cumplir con lo establecido por la institución como opción de grado, mediante un trabajo de investigación que podrá ser en forma de estudio de caso, la solución de un problema concreto o el análisis de una situación particular, o aquello que la institución defina como suficiente para la obtención del título. \\r\\nLa maestría de investigación será aquella que procure por el desarrollo de conocimientos, actitudes y habilidades científicas y una formación avanzada en investigación, innovación o creación que genere nuevos conocimientos, procesos y productos tecnológicos u obras o interpretaciones artísticas de interés cultural, según el caso. El trabajo de investigación resultado del proceso formativo debe evidenciar las competencias científicas, disciplinares o creativas propias del investigador, del creador o del intérprete artístico, de acuerdo con lo contemplado en el Sistema Nacional de Ciencia y Tecnología o el que haga sus veces', '6', '0'),
('2.5.3.2.6.5', 'Especialidades medicoquirúrgicas', 'Son los programas que permiten al médico la profundización en un área del conocimiento específico de la medicina y la adquisición de los conocimientos, desarrollo de actitudes, habilidades y destrezas avanzadas para la atención de pacientes en las diferentes etapas de su ciclo vital, con patologías de los diversos sistemas orgánicos que requieren atención especializada. \\r\\nPara este nivel de formación se requieren procesos de enseñanza-aprendizaje teóricos y prácticos. Lo práctico incluye el cumplimiento del tiempo de servicio en los escenarios de prácticas asistenciales y la intervención en un número de casos adecuado para asegurar el logro de los resultados de aprendizaje buscados por el programa. El estudiante deberá tener el acompañamiento y seguimiento requerido. \\r\\nDe conformidad con el artículo 247 de la Ley 100 de 1993, estos programas tendrán un tratamiento equivalente a los programas de maestría', '6', '0'),
('2.5.3.2.6.6', 'Programas de doctorado', 'Un programa de doctorado tiene como propósito la formación de investigadores con capacidad de realizar y orientar en forma autónoma procesos académicos e investigativos en un área específica del conocimiento y desarrollar, afianzar o profundizar conocimientos, actitudes y habilidades propias de este nivel de formación. Los resultados de las investigaciones de los estudiantes en este nivel de formación deben contribuir al avance del conocimiento, de acuerdo con lo contemplado en el Sistema Nacional de Ciencia y Tecnología o el que haga sus veces. ', '6', '0'),
('2.5.3.2.7.1', 'Ciclos propedéuticos', 'Un ciclo propedéutico es una fase de la educación que le permite al estudiante desarrollarse en su formación profesional siguiendo sus intereses y capacidades, para lo cual requiere un componente propedéutico que hace referencia al proceso por el cual se prepara a una persona para continuar su formación en educación superior, lo que supone una organización de los programas con flexibilidad, secuencialidad y complementariedad. \\r\\nCada programa que conforma el proceso formativo por ciclos propedéuticos debe conducir a un título que habilite de manera independiente para el desempeño laboral como técnico profesional, tecnólogo o profesional universitario, según lo definido por la Ley 749 de 2002, “por la cual se organiza el servicio público de la educación superior en las modalidades de formación técnica profesional y tecnológica, y se dictan otras disposiciones”, en coherencia con las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades), y la naturaleza jurídica, tipología, identidad y misión institucional. \\r\\nLa oferta de la formación por ciclos propedéuticos deberá preservar la independencia entre los programas que conforman el ciclo, para lo cual cada nivel deberá garantizar un perfil de formación pertinente de acuerdo con el nivel ofrecido, que le permita al egresado insertarse en el campo laboral y a su vez le posibilita continuar su formación mediante el acceso a un nivel formativo superior, dado por el componente propedéutico incluido en el diseño curricular. \\r\\nLas instituciones que de conformidad con la Ley 30 de 1992 “por medio de la cual se organiza el servicio público de la educación superior” y la Ley 115 de 1994, “por medio de la cual se expide la ley general de educación” tienen el carácter académico de Técnicas Profesionales o Tecnológicas, para ofrecer programas en el nivel tecnológico o profesional universitario, respectivamente, por ciclos propedéuticos, deben reformar sus estatutos y adelantar el proceso de redefinición previsto en la normatividad colombiana, previo a la solicitud de registro calificado', '7', '0'),
('2.5.3.2.7.2', 'Del registro calificado de programas en ciclos propedéuticos', 'La solicitud de registro calificado, de renovación o modificación para programas articulados por ciclos propedéuticos, deberá realizarse de manera independiente y simultánea para cada nivel, los cuales serán evaluados conjuntamente y, cuando proceda, el registro calificado o su renovación o su modificación se otorgará a cada uno. \\r\\nLas solicitudes de renovación y/o modificación para programas académicos articulados por ciclos propedéuticos deberán presentarse por cada programa que conforme la unidad propedéutica, identificando la relación entre los mismos. \\r\\nUna vez aprobados los programas estructurados en ciclos propedéuticos, se ofertarán y desarrollarán como una unidad', '7', '0'),
('2.5.3.2.8.1', 'Definición de trámite de registro calificado', 'Para efectos de la presente sección, se entenderá que el trámite de registro calificado es la suma de acciones coordinadas dentro de un trámite administrativo, con miras a obtener el reconocimiento por parte del Ministerio de Educación Nacional frente al cumplimiento de las condiciones de calidad indispensables para ofrecer programas académicos de educación superior de distintos niveles de formación, conforme con lo dispuesto en el artículo 1° de la Ley 1188 de 2008', '8', '0'),
('2.5.3.2.8.1.1', 'Prerradicación', 'La etapa de prerradicación de solicitud de registro calificado inicia con la presentación de los documentos aportados por la institución, la visita de verificación de condiciones institucionales, el informe que resulte de la visita de verificación, el concepto de condiciones institucionales emitido por la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces) y termina con la validación del concepto de la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces) por parte del Ministerio de Educación Nacional', '8', '18'),
('2.5.3.2.8.1.2', 'Presentación de documentos por parte de las instituciones', 'Para dar inicio a la etapa de prerradicación de solicitud de registro calificado, la institución por medio de su representante legal o su apoderado deberá suministrar a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces, la solicitud en la que manifieste su intención de acompañar y atender la visita de verificación de condiciones institucionales, diligenciando los formatos que el Ministerio de Educación Nacional haya dispuesto allí para tal fin, adjuntando la información que evidencie el cumplimiento de las mismas conforme con el artículo 2.5.3.2.3.1.1. y siguientes del presente capítulo, relacionado con las condiciones institucionales', '8', '18'),
('2.5.3.2.8.1.3', 'Verificación de documentación', 'El Ministerio de Educación Nacional verificará en los (5) cinco días hábiles siguientes contados a partir de que la institución suministre en el Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces, la documentación requerida que permita dar inicio a la etapa de prerradicación aducida en la presente sección', '8', '18'),
('2.5.3.2.8.1.4', 'Asignación de pares y visita de verificación de condiciones institucionales', 'Es el acto mediante el cual el Ministerio de Educación Nacional verifica el cumplimiento de las condiciones de carácter institucional que establece el artículo 2° de la Ley 1188 de 2008. \\r\\nRecibidos los documentos de la etapa de prerradicación de la solicitud en el Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces, por parte de la institución, el Ministerio de Educación Nacional designará los pares académicos haciendo uso del Banco de Pares, siguiendo el trámite de designación dispuesto en el artículo 2.5.3.2.8.2.4., determinando la fecha de la visita y su agenda. Para ello podrá contar con el apoyo de la Comisión Nacional Intersectorial de la Calidad de la Educación Superior (Conaces).La visita de verificación de condiciones institucionales se realizará máximo en (30) treinta días calendario, contados a partir de la verificación por parte del Ministerio de Educación Nacional de que la documentación es la suficiente. De la visita efectuada por los pares académicos se dejará evidencia mediante un acta de cierre, que deberá suscribirse al finalizar la misma', '8', '18');
INSERT INTO articulo (id, nombre, descripcion, fkidseccion, fkidsubseccion) VALUES
('2.5.3.2.8.1.5', 'Informe de condiciones institucionales', 'Dentro de los (5) cinco días hábiles siguientes a la realización de la visita, el par académico emitirá un informe en el que se señalan las conclusiones y recomendaciones respectivas, el cual deberá ser puesto a disposición del Ministerio de Educación Nacional, a través del Sistema de Aseguramiento de la Calidad de Educación Superior (SACES), o el que haga sus veces, en el mismo término. \\r\\nEl informe y el acta de cierre de visita serán cargados por el par y deberán ser comunicados a la institución a través del Sistema de Aseguramiento de la Calidad de Educación Superior (SACES), o el que haga sus veces, en el día hábil siguiente de la recepción por el Ministerio de Educación Nacional. \\r\\nPuesto a disposición de la institución el informe del par, esta contará con (15) quince días calendario para presentar sus apreciaciones, permitiéndosele complementar o subsanar lo señalado en el informe a través del Sistema de Aseguramiento de la Calidad de Educación Superior (SACES), o el que haga sus veces', '8', '18'),
('2.5.3.2.8.1.6', 'Concepto sobre las condiciones institucionales', 'La Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces), previo estudio de la documentación presentada en la etapa de prerradicación, del informe entregado por los pares académicos y de las manifestaciones efectuadas por la institución que puedan existir respecto del mismo, emitirá concepto sobre las condiciones institucionales, el cual podrá ser favorable o contar con observaciones, y será presentado para validación del Ministerio de Educación Nacional, quien posteriormente lo comunicará a la institución mediante el Sistema de Aseguramiento de la Calidad de Educación Superior (SACES), o el que haga sus veces. \\r\\nLa Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces) emitirá el concepto de que trata el presente artículo en un plazo no superior a cuarenta y cinco (45) días calendario, contados a partir de la finalización del término concedido a la institución para realizar las apreciaciones al informe del par. ', '8', '18'),
('2.5.3.2.8.1.7', 'Vigencia de las condiciones institucionales', 'La institución que haya obtenido concepto favorable de condiciones institucionales al haber culminado la etapa de prerradicación, podrá, a partir de la puesta en conocimiento del mismo mediante el Sistema de Aseguramiento de la Calidad de Educación Superior (SACES), o el que haga sus veces, y por un término de 7 años, iniciar la etapa de radicación de solicitudes de registro calificado sin necesidad de surtir nuevamente la etapa de Prerradicación. \\r\\nLa institución que no haya obtenido concepto favorable de condiciones institucionales podrá en todo caso continuar con la etapa de radicación de solicitud de registro calificado, y en ella se verificarán nuevamente las condiciones institucionales. \\r\\nLas instituciones deberán presentar solicitud de renovación de condiciones institucionales con 12 meses de antelación a la expiración de la vigencia referida en el presente artículo', '8', '18'),
('2.5.3.2.8.2', 'Etapas para solicitud de registro calificado', 'El procedimiento de registro calificado contará con 2 etapas, a saber: ', '8', '0'),
('2.5.3.2.8.2.1', 'Radicación de solicitud de registro calificado', 'La etapa de radicación de la solicitud de registro calificado está conformada por la presentación de solicitud de registro calificado; la radicación en debida forma por parte de la correspondiente institución, a partir de la cual inicia la actuación administrativa; la designación de los pares académicos; la visita de verificación de condiciones de calidad del programa; la emisión del concepto por parte de la respectiva sala de evaluación de la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces); y la decisión que resuelve la solicitud por parte del Ministerio de Educación Nacional', '8', '28'),
('2.5.3.2.8.2.2', 'Presentación de solicitud de registro calificado', 'El representante legal de la institución o su apoderado, una vez surtida la etapa de prerradicación, deberá presentar la correspondiente solicitud de registro calificado en el Sistema de Aseguramiento de Calidad de la Educación Superior (SACES) o en la herramienta que haga sus veces, diligenciando los formatos que el Ministerio de Educación Nacional haya dispuesto allí para tal fin, adjuntando la información que evidencie el cumplimiento de las condiciones de calidad del programa, señaladas en el artículo 2.5.3.2.3.2.1. del presente decreto. \\r\\nCuando se trate de programas del área de la salud que requieran de formación en el campo asistencial, la institución debe aportar, con la solicitud, los documentos que permitan verificar la relación docencia servicio acorde a la normatividad vigente', '8', '28'),
('2.5.3.2.8.2.3', 'Radicación en debida forma', 'El Ministerio de Educación Nacional, con el apoyo de la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces), determinarán la radicación en debida forma de la solicitud de registro calificado. Para ello, se verificará que la institución suministró en el Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES) o el que haga sus veces, la documentación requerida y por el mismo medio, la institución podrá verificar en un término no mayor a (5) cinco días hábiles, si la radicación fue realizada en forma debida. Este plazo se contará a partir de la presentación de la documentación por parte de la institución', '8', '28'),
('2.5.3.2.8.2.4', 'Designación de pares académicos', 'El Ministerio de Educación Nacional de conformidad con el procedimiento que establezca para ello, designará del Banco de Pares, los pares académicos en un término no superior a 15 días calendario, contados a partir de la radicación en debida forma. Los pares realizarán la visita de verificación de las condiciones de calidad del programa, previa comunicación a la institución a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces. \\r\\nLa institución podrá solicitar al Ministerio de Educación Nacional el cambio de los pares académicos, siempre que esta solicitud esté debidamente sustentada, dentro de los tres (3) días hábiles siguientes a la fecha de remisión de la comunicación de asignación a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces; si se encuentra mérito, el Ministerio de Educación Nacional procederá a designar nuevos pares académicos en el término de 5 días hábiles. \\r\\nPreviamente a su visita, el par o pares académicos deberá(n) estudiar la información y documentación presentada por la institución como soporte de la solicitud de registro calificado, conforme con los instructivos diseñados para tal fin por parte del Ministerio de Educación Nacional con miras a la construcción de verificaciones objetivas, que sean coherentes con la naturaleza jurídica, tipología, identidad y misión institucional, así como de las distintas modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades) de los programas', '8', '28'),
('2.5.3.2.8.2.5', 'Visita de verificación', 'El Ministerio de Educación Nacional dispondrá la realización de las visitas a que haya lugar e informará a la institución sobre las fechas y la agenda programada a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces. \\r\\nEl par o los pares académicos realizarán la(s) visita(s) en un tiempo no superior a 15 días calendario, verificando las condiciones de calidad del programa de la solicitud puesta a su disposición; dará por finalizada la visita a través de un acta de cierre; y contará con cinco (5) días hábiles posteriores a la visita para la presentación del informe a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces. Cuando sean dos o más los pares académicos a cargo de la verificación, cada uno de ellos deberá elaborar y presentar su informe por separado dentro del término común de cinco (5) días hábiles. \\r\\nUna vez el informe del par esté puesto a disposición de la institución a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces, esta contará con quince (15) días hábiles para presentar sus apreciaciones, permitiéndosele complementar o subsanar lo señalado en el informe. ', '8', '28'),
('2.5.3.2.8.2.6', 'Concepto', 'Determinada la radicación en debida forma y contando con el (los) informe(s) de verificación de las condiciones de calidad del programa dados por el (los) par(es), la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces) emitirá concepto con su recomendación, debidamente motivado, dirigido al Ministerio de Educación Nacional. \\r\\nPara la emisión del respectivo concepto, la Sala deberá sesionar con un número impar plural de integrantes de la sala. El concepto adoptado por la sala de evaluación deberá serlo por mayoría simple y deberá fundarse en el (los) informes del (los) par(es), la información presentada por la institución con la solicitud y la que esté disponible en el Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces. \\r\\nEl concepto que difiera sustancialmente del informe presentado por el (los) par(es) deberá sustentar de manera clara y precisa las razones que motivaron apartarse de dicho informe con fundamento en los sistemas nacionales de información de educación superior o cualquier otro medio probatorio. El Ministerio de Educación Nacional, dentro del término de quince (15) días hábiles, podrá convocar una nueva sesión de evaluación de la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces) y citar al par o pares académicos con el fin de que se presenten las explicaciones o justificaciones frente a lo consignado en el (los) informe(s)', '8', '28'),
('2.5.3.2.8.2.7', 'Decisión sobre el otorgamiento del registro calificado', 'Emitido el concepto por la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces), el Ministerio de Educación Nacional resolverá mediante acto administrativo la solicitud de registro calificado del programa, en un plazo no superior a sesenta (60) días calendario, contados desde que se recibió el informe del par. Contra esta decisión procederá el recurso de reposición, en los términos de la Ley 1437 de 2011 – Código de Procedimiento Administrativo y de lo Contencioso Administrativo– o la norma que lo modifique, derogue o sustituya', '8', '28'),
('2.5.3.2.9.1', 'De las instituciones acreditadas en alta calidad', 'En consideración al reconocimiento en alta calidad de las instituciones, por parte del Consejo Nacional de Acreditación y mientras dure la vigencia de su acreditación institucional, el Ministerio de Educación Nacional entenderá surtida la etapa de prerradicación de solicitud de registro calificado para los programas académicos de educación superior que sean ofrecidos y desarrollados en la sede que ostente la acreditación de alta calidad. \\r\\nEl registro calificado de estos programas, su renovación o modificación, será otorgado por el Ministerio de Educación Nacional, sin necesidad de adelantar las verificación y evaluación de las condiciones de calidad, previa solicitud en los formatos que para ello disponga el Ministerio de Educación Nacional, a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES) o el que haga sus veces', '9', '0'),
('2.5.3.2.9.2', 'De los programas acreditados en alta calidad', 'En el caso de los programas que hayan obtenido la acreditación en alta calidad y esta se encuentre vigente según la normatividad colombiana, el Ministerio de Educación Nacional procederá de oficio a la renovación del registro calificado del mismo, por el término de la vigencia de la acreditación del programa, si esta fuere superior a 7 años. \\r\\nEl término de la renovación del registro calificado se contará a partir de la fecha de ejecutoria del acto administrativo que otorga o renueva la acreditación en alta calidad', '9', '0'),
('2.5.3.2.9.3', 'De la negativa de la renovación de acreditación de alta calidad del programa', 'Si el programa no obtiene la renovación de la acreditación en alta calidad, la institución tendrá sesenta (60) días hábiles para aportar la documentación necesaria y solicitar ante el Ministerio de Educación Nacional la renovación del registro calificado a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES). En este caso, la vigencia del registro calificado del programa se extenderá hasta que el Ministerio de Educación Nacional resuelva de fondo la solicitud de renovación', '9', '0'),
('2.5.3.2.9.4', 'Instituciones y programas en proceso de acreditación', 'Las instituciones o programas que se encuentren en proceso de acreditación o de renovación de acreditación en alta calidad y que a su vez se encuentre en trámite de renovación del registro calificado y que este se hubiese presentado dentro del término previsto para tal efecto, continuará hasta su culminación y podrá interrumpirse dicho proceso por una sola vez y hasta por el término de seis meses el plazo establecido en el artículo 3° de la Ley 1188 de 2008. De obtenerse la acreditación de la institución o de los programas, será otorgado el registro calificado, en caso contrario se continuará con el trámite establecido en la Sección 8 del presente CAPÍTULO, Trámite del Registro Calificado', '9', '0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla fuente
--

CREATE TABLE fuente (
  id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
  nombre varchar(2000) NOT NULL
);

--
-- Volcado de datos para la tabla fuente
--

INSERT INTO fuente (nombre) VALUES
('Fuente 1'),
('Fuente 3'),
('Fuente 4'),
('Fuente 5'),
('Fuente 7');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla fuentesporindicador
--

CREATE TABLE fuentesporindicador (
  fkidfuente int NOT NULL,
  fkidindicador int NOT NULL,
  PRIMARY KEY(fkidfuente,fkidindicador)
);

--
-- Volcado de datos para la tabla fuentesporindicador
--

INSERT INTO fuentesporindicador (fkidfuente, fkidindicador) VALUES
(1, 31),
(3, 30),
(3, 31),
(4, 31),
(5, 31);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla indicador
--

CREATE TABLE indicador (
  id int NOT NULL IDENTITY(30,1) PRIMARY KEY,
  codigo varchar(50) NOT NULL,
  nombre varchar(100) NOT NULL,
  objetivo varchar(4000) NOT NULL,
  alcance varchar(1000) NOT NULL,
  formula varchar(1000) NOT NULL,
  fkidtipoindicador int NOT NULL,
  fkidunidadmedicion int NOT NULL,
  meta varchar(1000) NOT NULL,
  fkidsentido int NOT NULL,
  fkidfrecuencia int NOT NULL,
  fkidarticulo varchar(20) DEFAULT NULL,
  fkidliteral varchar(20) DEFAULT NULL,
  fkidnumeral varchar(20) DEFAULT NULL,
  fkidparagrafo varchar(20) DEFAULT NULL
);

--
-- Volcado de datos para la tabla indicador
--

INSERT INTO indicador (codigo, nombre, objetivo, alcance, formula, fkidtipoindicador, fkidunidadmedicion, meta, fkidsentido, fkidfrecuencia, fkidarticulo, fkidliteral, fkidnumeral, fkidparagrafo) VALUES
('COD 555', 'NPM 555', 'Objetivo Indicador COD 555', 'Alcance Indicador COD 555', '(sin(x)*sin(y))**2', 5, 15, 'Meta Indicador COD 555 modifi', 5, 5, '2.5.3.2.11.5', '0', '0', '0'),
('COD 111', 'NPM 111', 'Objetivo Indicador COD 111', 'Alcance Indicador COD 111', '(sin(x)*sin(y))**2', 1, 12, 'Meta Indicador COD 111', 3, 1, '2.5.3.2.11.1', '0', '0', '0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla literal
--

CREATE TABLE literal (
  id varchar(20) NOT NULL PRIMARY KEY,
  descripcion varchar(1000) NOT NULL,
  fkidarticulo varchar(20) NOT NULL
);

--
-- Volcado de datos para la tabla literal
--

INSERT INTO literal (id, descripcion, fkidarticulo) VALUES
('0', 'NA', '0'),
('a2.5.3.2.1.3', 'Ministerio de Educación Nacional (MEN)', '2.5.3.2.1.3'),
('a2.5.3.2.10.2', 'Denominación o titulación del programa', '2.5.3.2.10.2'),
('a2.5.3.2.3.1.2', 'Mecanismos de selección y evaluación de estudiantes. El reglamento estudiantil, o su equivalente, debe establecer los requisitos y criterios precisos y transparentes para la inscripción, admisión, ingreso, matrícula, deberes y derechos, distinciones e incentivos, régimen disciplinario y demás aspectos académicos, que faciliten a los estudiantes la graduación en condiciones de calidad, los cuales deberán ser coherentes y consistentes con su naturaleza jurídica, tipología, identidad y misión institucional. \\r\\nAsí mismo, la institución deberá contar con políticas e información cualitativa y cuantitativa, que le permita establecer las estrategias conducentes a mejorar el bienestar, permanencia y graduación de los estudiantes', '2.5.3.2.3.1.2'),
('a2.5.3.2.3.1.3', 'Gobierno institucional y rendición de cuentas', '2.5.3.2.3.1.3'),
('a2.5.3.2.3.1.4', 'La sistematización, gestión y uso de la información necesaria para poder propo¬ner e implementar medidas de mejoramiento, teniendo en cuenta la información registrada en los sistemas de información de la educación superior', '2.5.3.2.3.1.4'),
('a2.5.3.2.3.1.7', 'Gestión del talento humano. La institución deberá desarrollar políticas y meca¬nismos para atraer, desarrollar y retener el talento humano acorde con su misión', '2.5.3.2.3.1.7'),
('a2.5.3.2.3.2.3', 'El estado de la oferta de educación del área del programa, y de la ocupación, profesión, arte, u oficio, cuando sea del caso, en los ámbitos nacionales y de las proyecciones del conocimiento en el contexto global', '2.5.3.2.3.2.3'),
('a2.5.3.2.3.2.4', 'Componentes formativos: se refieren a la definición del plan general de estudios, deberá estar representado en créditos académicos conforme con los resultados de aprendizaje proyectados, la formación integral, las actividades académicas que evidencien estrategias de flexibilización curricular, y los perfiles de egreso, en ar¬monía con las habilidades del contexto internacional, nacional, y local orientadas al desarrollo de las capacidades para aprender a aprender', '2.5.3.2.3.2.4'),
('a2.5.3.2.3.2.6', 'La comprensión teórica para la formación de un pensamiento innovador, con capacidad de construir, ejecutar, controlar y operar los medios y procesos para la solución de problemas que demandan los sectores productivos y de servicios del país', '2.5.3.2.3.2.6'),
('a2.5.3.2.5.4', 'El objeto del convenio específico y su relación con el desarrollo del programa académico', '2.5.3.2.5.4'),
('a2.5.3.2.6.2', 'Elementos para ampliar el conocimiento del marco teórico y la perspectiva futu¬ra de su ocupación, disciplina o profesión', '2.5.3.2.6.2'),
('a2.5.3.2.8.2', 'Prerradicación de solicitud de registro calificado', '2.5.3.2.8.2'),
('aa2.5.3.2.3.1.3', 'La institución deberá dar cuenta de: a) Gobierno institucional y rendición de cuentas. La institución deberá contar con un gobierno, entendido como el sistema de políticas, estrategias, decisiones, es¬tructuras y procesos, encaminadas al cumplimiento de su misión bajo los princi¬pios de gobernabilidad y gobernanza. Como marco de decisión deberá contar con el proyecto educativo institucional o lo que haga sus veces. \\r\\nPara ello, la institución deberá establecer mecanismos para la rendición de cuentas en cabeza de su representante legal y sus órganos de gobierno, capaces de responder e informar de manera periódica y participativa sobre el desempeño institucional. A su vez, la institución deberá demostrar la participación de estudiantes, profesores y egresados, en los procesos de toma de decisiones en coherencia con su naturaleza jurídica, tipología, identidad y misión institucional', '2.5.3.2.3.1.3'),
('b2.5.3.2.1.3', 'Ministerio de Salud y Protección Social', '2.5.3.2.1.3'),
('b2.5.3.2.10.2', 'Número total de créditos del plan de estudios', '2.5.3.2.10.2'),
('b2.5.3.2.3.1.2', 'Mecanismos de selección y evaluación de profesores. La institución deberá contar con un grupo de profesores que, en términos de dedicación, vinculación y disponibilidad, respondan a las condiciones de calidad en coherencia con su naturaleza jurídica, tipología, identidad y misión institucional, para el desarro¬llo de sus labores formativas, académicas, docentes, científicas, culturales y de extensión, acorde con la normatividad vigente. A su vez, los profesores deberán facilitar la implementación de los planes institucionales y el desarrollo de los procesos formativos de acuerdo con la cifra proyectada de estudiantes. \\r\\nEl reglamento profesoral, o su equivalente, deberá proveer los criterios y mecanismos para el ingreso, desarrollo, permanencia y evaluación de los profesores, orientados bajo principios de transparencia, mérito y objetividad. ', '2.5.3.2.3.1.2'),
('b2.5.3.2.3.1.3', 'Políticas institucionales', '2.5.3.2.3.1.3'),
('b2.5.3.2.3.1.4', 'Mecanismos para evidenciar la evolución del cumplimiento de las condiciones de calidad de los resultados académicos', '2.5.3.2.3.1.4'),
('b2.5.3.2.3.1.7', 'Recursos físicos y tecnológicos. La institución deberá demostrar la disponibili¬dad, acceso y uso de infraestructura física y tecnológica coherente con los reque¬rimientos de las labores formativas, académicas, docentes, científicas, culturales y de extensión, de bienestar y de apoyo a la comunidad académica, definidos por la institución y que sean comunes para todos los programas en sus niveles de formación y modalidades (presencial, a distancia, virtual, dual u otros desarro¬llos que combinen e integren las anteriores modalidades). La institución deberá contar, por lo menos con: ', '2.5.3.2.3.1.7'),
('b2.5.3.2.3.2.3', 'Las necesidades de la región y del país que, según la propuesta, tengan rela¬ción directa con el programa en armonía con referentes internacionales, si estos vienen al caso, atendiendo a las dimensiones que determinan las modalidades (presencial, a distancia, virtual, dual u otros desarrollos que combinen e integren las anteriores modalidades) y las asociadas al registro calificado solicitado', '2.5.3.2.3.2.3'),
('b2.5.3.2.3.2.4', 'Componentes pedagógicos: se refieren a los lineamientos e innovación pedagó¬gica y didáctica que cada institución integre al programa según su modalidad', '2.5.3.2.3.2.4'),
('b2.5.3.2.3.2.6', 'La incorporación de la formación investigativa de los estudiantes en concordan¬cia con el nivel educativo y sus objetivos, el uso de las tecnologías de la informa¬ción y de la comunicación', '2.5.3.2.3.2.6'),
('b2.5.3.2.5.4', 'El régimen de responsabilidad de las instituciones en relación con aspectos de orden académico, como la titularidad y el otorgamiento de los respectivos títulos', '2.5.3.2.5.4'),
('b2.5.3.2.6.2', 'La comprensión de la utilidad y la aplicación de los conocimientos en los entor¬nos sociales e institucionales, desde una perspectiva ética', '2.5.3.2.6.2'),
('b2.5.3.2.8.2', 'Radicación de solicitud de registro calificado', '2.5.3.2.8.2'),
('bb2.5.3.2.3.1.3', 'b) Políticas institucionales. Son el conjunto de directrices establecidas por la ins¬titución con el fin de orientar y facilitar el logro de sus objetivos por parte de los diferentes estamentos, en los distintos niveles formativos y modalidades en coherencia con su naturaleza jurídica, tipología, identidad y misión institucional. \\r\\nLa institución deberá dar cuenta de la existencia, implementación, aplicación y resultados del cumplimiento de las siguientes políticas institucionales: (Las políticas institucionales deberán atender a la normatividad vigente en materia de protección de datos, propiedad intelectual, responsabilidad social y ambiental, así como a las que estime necesarias para responder a las expectativas y necesidades de los contextos locales, regionales y globales. )', '2.5.3.2.3.1.3'),
('c2.5.3.2.1.3', 'Consejo Nacional de Educación Superior (CESU)', '2.5.3.2.1.3'),
('c2.5.3.2.10.2', 'Cambio de estructura de un programa para incorporar el componente propedéu¬tico', '2.5.3.2.10.2'),
('c2.5.3.2.3.1.3', 'Gestión de información y ', '2.5.3.2.3.1.3'),
('c2.5.3.2.3.1.4', 'Mecanismos que recojan la apreciación de la comunidad académica y de los diferentes grupos de interés con el fin de contribuir al proceso. ', '2.5.3.2.3.1.4'),
('c2.5.3.2.3.1.7', 'Recursos financieros. La institución deberá demostrar la existencia, divulga¬ción, implementación y resultados de la aplicación de las políticas financieras orientadas al desarrollo de las labores formativas, académicas, docentes, científi¬cas, culturales y de extensión en coherencia con su naturaleza jurídica, tipología e identidad institucional. \\r\\nLa institución deberá demostrar condiciones financieras sostenibles y orientadas a lograr el fortalecimiento en condiciones de calidad institucional y de programas, así como la obtención de los resultados académicos propuestos', '2.5.3.2.3.1.7'),
('c2.5.3.2.3.2.3', 'Una justificación de los atributos o factores que constituyen los rasgos distintivos del programa con relación a los ya existentes en el área o las áreas del conoci¬miento y la(s) región(es) donde se desarrollará el programa, en coherencia con su naturaleza jurídica, tipología e identidad institucional', '2.5.3.2.3.2.3'),
('c2.5.3.2.3.2.4', 'Componentes de interacción: Se refiere a la creación y fortalecimiento de víncu¬los entre la institución y los diversos actores en pro de la armonización del pro¬grama con los contextos locales, regionales y globales; así como, al desarrollo de habilidades en estudiantes y profesores para interrelacionarse. Así mismo, el programa deberá establecer las condiciones que favorezcan la internacionaliza¬ción del currículo y el desarrollo de una segunda lengua', '2.5.3.2.3.2.4'),
('c2.5.3.2.3.2.6', 'El desarrollo de nuevos productos, procesos y usos de productos ya existentes. ', '2.5.3.2.3.2.6'),
('c2.5.3.2.5.4', 'Los compromisos de la institución o instituciones en el seguimiento y evaluación del programa académico', '2.5.3.2.5.4'),
('c2.5.3.2.6.2', 'Conocimientos avanzados y profundos en los campos de las ciencias, las tecno¬logías, las artes o las humanidades', '2.5.3.2.6.2'),
('cc2.5.3.2.3.1.3', 'c) Gestión de la información. La institución deberá determinar el conjunto de fuentes, procesos, herramientas y usuarios que, articulados entre sí, posibiliten y faciliten la recopilación, divulgación y organización de la información. Esta información deberá ser utilizada para la planeación, monitoreo, y evaluación de sus actividades y toma de decisiones. \\r\\nLa información deberá ser específica y fiel a la realidad. Este criterio aplica a la publicidad y a las comunicaciones internas, conforme con la normatividad que se encuentre vigente en materia de protección de datos. \\r\\nIgualmente, la institución deberá tener actualizada la información en todos los sistemas nacionales de información de la educación superior, al momento de solicitar el registro calificado, su modificación o renovación', '2.5.3.2.3.1.3'),
('d2.5.3.2.1.3', 'Consejo Nacional de Acreditación (CNA)', '2.5.3.2.1.3'),
('d2.5.3.2.10.2', 'Cualquier cambio de modalidad de un programa', '2.5.3.2.10.2'),
('d2.5.3.2.3.1.3', 'Arquitectura institucional que soportan las estrategias, planes y actividades pro¬pias del quehacer institucional', '2.5.3.2.3.1.3'),
('d2.5.3.2.3.1.4', 'La articulación de los programas de mejoramiento con la planeación y el presu¬puesto general de la institución. ', '2.5.3.2.3.1.4'),
('d2.5.3.2.3.2.4', 'Conceptualización teórica y epistemológica del programa: El programa deberá hacer referencia a los fundamentos teóricos del programa y a la descripción de la naturaleza del objeto de estudio y sus formas de conocimiento', '2.5.3.2.3.2.4'),
('d2.5.3.2.3.2.6', 'La capacidad para dar respuestas transformadoras a problemas locales, regiona¬les y globales, e indagar sobre la realidad social y ambiental, entre otros, a partir del uso del conocimiento como herramienta de desarrollo', '2.5.3.2.3.2.6'),
('d2.5.3.2.5.4', 'Los reglamentos, o su equivalente, de estudiantes y de profesores aplicables a los estudiantes y profesores del programa', '2.5.3.2.5.4'),
('d2.5.3.2.6.2', 'La comunicación, argumentación, validación y apropiación de conocimientos en diferentes áreas, acordes con la complejidad de cada nivel de formación, para divulgar en la sociedad los desarrollos propios de la ocupación, la disciplina o la profesión', '2.5.3.2.6.2'),
('dd2.5.3.2.3.1.3', 'd) Arquitectura institucional. Entendida como la articulación entre procesos, orga¬nización y cargos para el cumplimiento de las labores formativas, académicas, docentes, científicas, culturales y de extensión. La institución dará a conocer al Ministerio de Educación Nacional y a la comunidad académica en general, la estructura y las relaciones entre los niveles organizacionales en coherencia con su naturaleza jurídica, tipología, identidad y misión institucional', '2.5.3.2.3.1.3'),
('e2.5.3.2.1.3', 'Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educa¬ción Superior (Conaces)', '2.5.3.2.1.3'),
('e2.5.3.2.10.2', 'La inclusión dentro del registro único de una nueva modalidad, distinta a la otor¬gada inicialmente', '2.5.3.2.10.2'),
('e2.5.3.2.3.1.4', 'Mecanismos que permitan procesos continuos de autoevaluación y autorregu¬lación que se reflejen en informes periódicos fijados en consideración con la duración de los programas objeto de registro calificado. ', '2.5.3.2.3.1.4'),
('e2.5.3.2.3.2.4', 'Mecanismos de evaluación: se refiere a los instrumentos de medición y segui¬miento que permitan hacer los análisis necesarios para la oportuna toma de deci¬siones, con el propósito de mejorar el desempeño de profesores y estudiantes con relación a los resultados de aprendizaje establecidos en el programa', '2.5.3.2.3.2.4'),
('e2.5.3.2.3.2.6', 'Aquellos programas que hicieron explícita la incorporación de la investigación, innovación y/o creación artística deberán evidenciar sus resultados de acuerdo con los lineamientos establecidos por el sistema nacional de ciencia y tecnología u otros afines', '2.5.3.2.3.2.6'),
('e2.5.3.2.5.4', 'Los mecanismos y estrategias para el desarrollo conjunto de los procesos de diseño y gestión de las actividades académicas del programa', '2.5.3.2.5.4'),
('e2.5.3.2.6.2', 'Experiencias que desarrollen e incentiven la apreciación cultural y el desarrollo personal a lo largo de la vida', '2.5.3.2.6.2'),
('f2.5.3.2.1.3', 'Ministerio de Ciencia, Tecnología e Innovación (CTel)', '2.5.3.2.1.3'),
('f2.5.3.2.10.2', 'Ampliación o modificación de los lugares de desarrollo', '2.5.3.2.10.2'),
('f2.5.3.2.5.4', 'Las obligaciones de la institución o instituciones en cuanto al intercambio de servicios docentes e investigativos', '2.5.3.2.5.4'),
('g2.5.3.2.1.3', 'Instituto Colombiano para la Evaluación de la Educación (Icfes)', '2.5.3.2.1.3'),
('g2.5.3.2.10.2', 'Convenios que apoyan el programa, cuando de ellos dependa su desarrollo', '2.5.3.2.10.2'),
('g2.5.3.2.5.4', 'La responsabilidad sobre los estudiantes, en caso de terminación anticipada del convenio', '2.5.3.2.5.4'),
('h2.5.3.2.1.3', 'Instituto Colombiano de Crédito Educativo y Estudios Técnicos en el Exterior “Mariano Ospina Pérez” (Icetex)', '2.5.3.2.1.3'),
('h2.5.3.2.10.2', 'Cupos en los programas de la salud que requieran de la evaluación de la relación docencia servicio', '2.5.3.2.10.2'),
('h2.5.3.2.5.4', 'La responsabilidad sobre la información y los datos obtenidos durante el desarro¬llo del programa y en caso de terminación del convenio', '2.5.3.2.5.4'),
('i2.5.3.2.1.3', 'Comisión Intersectorial de Talento Humano en Salud (CITHS)', '2.5.3.2.1.3'),
('j2.5.3.2.1.3', 'Las instituciones de educación superior y aquellas habilitadas por la ley para ofrecer y desarrollar programas de educación superior', '2.5.3.2.1.3'),
('k2.5.3.2.1.3', 'La comunidad académica y científica en general', '2.5.3.2.1.3'),
('l2.5.3.2.1.3', 'Pares académicos', '2.5.3.2.1.3'),
('m2.5.3.2.1.3', 'Todos aquellos entes que intervienen en el desarrollo de la Educación Superior', '2.5.3.2.1.3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla numeral
--

CREATE TABLE numeral (
  id varchar(20) NOT NULL PRIMARY KEY,
  descripcion varchar(1000) NOT NULL,
  fkidliteral varchar(20) NOT NULL
);

--
-- Volcado de datos para la tabla numeral
--

INSERT INTO numeral (id, descripcion, fkidliteral) VALUES
('0', 'NA', '0'),
('1b2.5.3.2.3.1.7', 'Infraestructura física y tecnológica que prevea la proyección de crecimiento ins¬titucional, los cambios en las labores formativas, académicas, docentes, científi¬cas, culturales y de extensión y las condiciones de bienestar', 'b2.5.3.2.3.1.7'),
('1bb2.5.3.2.3.1.3', 'Políticas académicas asociadas a currículo, resultados de aprendizaje, créditos y actividades', 'bb2.5.3.2.3.1.3'),
('2b2.5.3.2.3.1.7', 'Políticas de renovación y actualización de infraestructura física y tecnológica que atiendan el desarrollo de las labores formativas, académicas, docentes, cien¬tíficas, culturales y de extensión y que permitan avanzar gradualmente en las condiciones de accesibilidad de la comunidad académica en el marco de las po¬líticas de inclusión', 'b2.5.3.2.3.1.7'),
('2bb2.5.3.2.3.1.3', 'Políticas de gestión institucional y bienestar', 'bb2.5.3.2.3.1.3'),
('3b2.5.3.2.3.1.7', 'Ambientes de aprendizaje que promuevan la formación integral y los encuentros de la comunidad para el desarrollo de la cultura y la ciudadanía', 'b2.5.3.2.3.1.7'),
('3bb2.5.3.2.3.1.3', 'Políticas de investigación, innovación, creación artística y cultural. \\r\\nLas políticas institucionales deberán atender a la normatividad vigente en materia de protección de datos, propiedad intelectual, responsabilidad social y ambiental, así como a las que estime necesarias para responder a las expectativas y necesidades de los contextos locales, regionales y globales', 'bb2.5.3.2.3.1.3'),
('4b2.5.3.2.3.1.7', 'Permisos de autorización del uso del suelo para la actividad de educación o equi¬valentes y evidencias del cumplimiento de las normas vigentes de seguridad, accesibilidad y condiciones físicas como ventilación, iluminación, mobiliario, de acuerdo con el tamaño y características de la población que está vinculada a la institución', 'b2.5.3.2.3.1.7'),
('5b2.5.3.2.3.1.7', 'Licencias para la infraestructura tecnológica y recursos virtuales utilizados, con¬forme con las normas de derecho de autor y demás legislación vigente', 'b2.5.3.2.3.1.7');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla paragrafo
--

CREATE TABLE paragrafo (
  id varchar(20) NOT NULL PRIMARY KEY,
  descripcion varchar(4000) NOT NULL,
  fkidarticulo varchar(20) NOT NULL
);

--
-- Volcado de datos para la tabla paragrafo
--

INSERT INTO paragrafo (id, descripcion, fkidarticulo) VALUES
('0', 'NA', '0'),
('12.5.3.2.1.3', 'Para todos los efectos del presente capítulo se entienden por “Instituciones”, las instituciones de educación superior y todas aquellas habilitadas por la ley para la oferta y desarrollo de programas de educación superior', '2.5.3.2.1.3'),
('12.5.3.2.10.1', 'Si la institución radica la solicitud de renovación de registro calificado con la antelación señalada en el inciso primero de este artículo, el registro calificado se entenderá prorrogado hasta que se produzca decisión de fondo por parte del Ministerio de Educación Nacional. En ese sentido, la institución podrá recibir nuevas cohortes de estudiantes en el programa en mención hasta tanto se produzca dicha decisión', '2.5.3.2.10.1'),
('12.5.3.2.10.2', 'El cambio de la denominación del programa autorizado por el Ministerio de Educación Nacional habilita a la institución para otorgar el título correspondiente a los estudiantes que hayan iniciado la cohorte con posterioridad a la fecha de dicha modificación. Los estudiantes de las cohortes iniciadas con anterioridad al cambio de denominación podrán optar por obtener el título correspondiente a la nueva denominación según lo soliciten a la institución o en todo caso con su consentimiento expreso; de no mediar solicitud, los estudiantes continuarán con las mismas condiciones del registro calificado que los amparaba al iniciar sus estudios', '2.5.3.2.10.2'),
('12.5.3.2.10.4', 'Lo referente a ampliación del lugar de desarrollo para instituciones y programas acreditados en alta calidad, se regirá conforme a lo dispuesto en el artículo 2.5.3.2.9.1. y siguientes del presente decreto', '2.5.3.2.10.4'),
('12.5.3.2.3.1.7', 'Para los programas en el área de la salud que impliquen formación en el campo asistencial, los cupos de matrícula deberán estar sujetos a la capacidad autorizada a los escenarios de práctica', '2.5.3.2.3.1.7'),
('12.5.3.2.3.1.8', 'Para iniciar la etapa de preradicación, conforme con el artículo 2.5.3.2.8.1.1. y siguientes del presente Capítulo, las instituciones deberán presentar un informe de autoevaluación de las condiciones institucionales que propenda por el mejoramiento, el cual será verificado por los pares durante su visita. \\r\\nPara aquellas instituciones que van a iniciar el trámite de registro calificado por primera vez, deberán presentar un plan de desarrollo, o el que haga sus veces, que contemple mecanismos y estrategias en pro del mejoramiento de las condiciones institucionales, en armonía con su misión', '2.5.3.2.3.1.8'),
('12.5.3.2.3.2.1', 'El Ministerio de Educación Nacional reglamentará el mecanismo de oferta y desarrollo de programas académicos de educación superior, en zonas rurales con condiciones de difícil acceso a educación superior en un término no superior a doce (12) meses, contados a partir de la presente modificación', '2.5.3.2.3.2.1'),
('12.5.3.2.3.2.10', 'El programa podrá demostrar la disponibilidad de la infraestructura por medio de convenios o contratos vigentes en coherencia con la duración del registro calificado que deberán incluir en sus cláusulas los alcances de dicha disponibilidad en términos de horarios y capacidad. En todos los casos dicha infraestructura deberá cumplir con la normatividad vigente', '2.5.3.2.3.2.10'),
('12.5.3.2.3.2.2', 'Las denominaciones no existentes en el Sistema Nacional de Información de la Educación Superior (SNIES) deberán incluir una argumentación desde el (los) campo(s) del conocimiento y desde la pertinencia con las necesidades del país y de las regiones, en concordancia con el campo de ocupación, las normas que regulan el ejercicio de la profesión y el marco nacional de cualificaciones. Se podrá tener en cuenta referentes internacionales como los dados por: nomenclatura internacional de la Organización de las Naciones Unidas para la Educación, la Ciencia y la Cultura (Unesco), estándares internacionales los campos de ciencia y tecnología, Clasificación Internacional Uniforme de Ocupaciones (CIUO), en inglés ISCO, entre otras', '2.5.3.2.3.2.2'),
('12.5.3.2.3.2.4', 'En el caso de los programas por ciclos propedéuticos, además se deberá describir el componente propedéutico que hace parte de los programas y las competencias asociadas a cada nivel de formación. ', '2.5.3.2.3.2.4'),
('12.5.3.2.3.2.9', 'La institución deberá informar y demostrar, respecto a las modalidades de los programas que requieran la presencia de los estudiantes en centros de tutoría, de prácticas, clínicas o talleres, que cuenta con los medios educativos en el lugar donde se realizarán', '2.5.3.2.3.2.9'),
('12.5.3.2.5.2', 'En el caso de convenios en los que participen instituciones de educación superior extranjeras o institutos o centros de investigación, el registro del programa en el Sistema Nacional de Información de la Educación Superior (SNIES), se efectuará a nombre de la o las instituciones de educación superior reconocidas en Colombia. ', '2.5.3.2.5.2'),
('12.5.3.2.5.4', 'Cualquier modificación al convenio relacionada con los elementos señalados en el artículo anterior, deberá ser informada para su evaluación al Ministerio de Educación Nacional, quien procederá a su autorización si lo considera pertinente para asegurar las condiciones de calidad del programa', '2.5.3.2.5.4'),
('12.5.3.2.6.4', 'Los programas de maestrías de profundización y de investigación tendrán registros calificados independientes, dado que son diferentes sus condiciones curriculares y de perfil del egresado', '2.5.3.2.6.4'),
('12.5.3.2.8.1.2', 'Cuando por razones técnicas no se pueda realizar la solicitud a través del Sistema de Aseguramiento de la Calidad en Educación Superior (SACES), o la herramienta que el Ministerio de Educación Nacional haya dispuesto para el efecto, esta podrá ser presentada en medio físico y/o digital en la Oficina de Atención al Ciudadano del Ministerio de Educación Nacional', '2.5.3.2.8.1.2'),
('12.5.3.2.8.1.3', 'En caso de que la documentación suministrada por la institución no se encuentre completa, el Ministerio de Educación Nacional requerirá a la institución para que la complete en el término máximo de (30) treinta días calendario. \\r\\nSe entenderá que la institución ha desistido de la etapa de prerradicación de solicitud de registro calificado, cuando no satisfaga el requerimiento antes de vencer el plazo concedido', '2.5.3.2.8.1.3'),
('12.5.3.2.8.1.6', 'En caso de que el concepto sobre condiciones institucionales contenga observaciones, la institución dentro del término de (15) quince días calendario, contados a partir de la puesta en conocimiento del mismo, mediante el Sistema de Aseguramiento de la Calidad de Educación Superior (SACES), o el que haga sus veces, deberá evidenciar el análisis de las observaciones emitidas por la Comisión Nacional Intersectorial de Aseguramiento de la Calidad de la Educación Superior (Conaces), mediante un informe, presentado una única vez, debidamente soportado que justifique la implementación de dichas observaciones o no, el cual será evaluado por la respectiva sala de la Conaces. Dicho plazo podrá ser prorrogable por igual término una sola vez. \\r\\nSi vencidos los términos establecidos en este parágrafo, la institución no ha presentado el informe respectivo, se entenderá desistida la etapa de prerradicación de la solicitud de registro calificado por parte de la institución', '2.5.3.2.8.1.6'),
('12.5.3.2.8.2.2', 'Cuando por razones técnicas no se pueda realizar la solicitud a través del Sistema de Aseguramiento de la Calidad en Educación Superior (SACES), o la herramienta que el Ministerio de Educación Nacional haya dispuesto para el efecto, esta podrá ser presentada en medio físico y/o digital en la Oficina de Atención al Ciudadano del Ministerio de Educación Nacional', '2.5.3.2.8.2.2'),
('12.5.3.2.8.2.3', 'En caso de verificarse que la documentación suministrada por la institución no se encuentre completa, el Ministerio de Educación Nacional requerirá a la institución, a través del Sistema de Aseguramiento de la Calidad de la Educación Superior (SACES), o el que haga sus veces, para que complete en el término máximo de treinta (30) días calendario dicha información. \\r\\nSe entenderá que la institución ha desistido de la etapa de solicitud de registro calificado cuando no satisfaga el requerimiento dentro del plazo concedido', '2.5.3.2.8.2.3'),
('12.5.3.2.9.1', 'Los programas acreditados de instituciones acreditadas en alta calidad podrán ser ofrecidos en cualquier parte del territorio nacional, previa solicitud de registro calificado que será otorgado sin la verificación y evaluación de las condiciones de calidad', '2.5.3.2.9.1'),
('12.5.3.2.9.2', 'Los programas acreditados de instituciones no acreditadas en alta calidad que se pretendan desarrollar en lugares donde la institución no cuente con oferta vigente de programas, la institución deberá adelantar la etapa de prerradicación de solicitud de registro calificado, salvo que medie para el desarrollo del programa, un convenio vigente con una institución acreditada o con una institución cuyas condiciones de calidad institucionales se encuentren vigentes', '2.5.3.2.9.2'),
('22.5.3.2.10.2', 'En atención al reconocimiento en alta calidad de las instituciones y programas por parte del Consejo Nacional de Acreditación, las solicitudes de modificación que eleven ante el Ministerio de Educación Nacional, no requerirán de la evaluación por parte de la Conaces, siempre y cuando tal reconocimiento se encuentre vigente', '2.5.3.2.10.2'),
('22.5.3.2.10.4', 'En todo caso, los programas del área de la salud, que requieran formación en el campo asistencial, estarán sujetos a la evaluación de la relación docencia servicio de acuerdo con la normatividad vigente', '2.5.3.2.10.4'),
('22.5.3.2.3.1.7', 'La institución podrá demostrar la disponibilidad de los recursos físicos y tecnológicos, por medio de convenios o contratos para la prestación de servicios, uso y goce de bienes muebles e inmuebles. Los convenios o contratos deberán incluir en sus cláusulas los alcances de dicha disponibilidad en términos de horarios y capacidad, durante la vigencia del registro calificado', '2.5.3.2.3.1.7'),
('22.5.3.2.3.2.9', 'Para los programas en áreas de la salud que impliquen formación en el campo asistencial es indispensable la disponibilidad de escenarios de práctica de conformidad con las normas vigentes', '2.5.3.2.3.2.9'),
('22.5.3.2.5.2', 'Para programas con registro calificado vigente, la intención de ofrecer y desarrollar programas académicos en colaboración a través de un convenio con una institución de educación superior nacional o internacional se entenderá como una modificación del registro calificado. En estos casos, la institución que cuente con el registro del programa en el Sistema Nacional de Información de la Educación Superior (SNIES) deberá tramitar una modificación al registro calificado ante el Ministerio de Educación Nacional de conformidad con lo dispuesto en el artículo 2.5.3.2.10.2. del presente decreto', '2.5.3.2.5.2'),
('22.5.3.2.5.4', 'La solicitud de registro calificado para ofrecer y desarrollar un programa académico en convenio entre instituciones deberá estar suscrita conjuntamente por los representantes legales o apoderados de las instituciones, o quien esté debidamente autorizado para tal fin. Aplica para las instituciones nacionales y las extranjeras', '2.5.3.2.5.4'),
('22.5.3.2.8.2.2', 'Para los programas en el área de la salud que impliquen formación en el campo asistencial, los cupos de matrícula deberán estar sujetos a la capacidad autorizada a los escenarios de práctica. De igual manera, se deberá acatar lo dispuesto en el artículo 101 de la Ley 1438 de 2011, “por medio de la cual se reforma el Sistema General de Seguridad Social en Salud y se dictan otras disposiciones”, respecto al concepto de pertinencia', '2.5.3.2.8.2.2'),
('22.5.3.2.9.1', 'Los programas no acreditados de las instituciones acreditadas en alta calidad que se pretendan desarrollar en lugares donde la institución no cuenta con oferta vigente de programas, adelantarán el trámite de verificación y evaluación de las condiciones de calidad tanto institucionales como de programas, salvo que medie para ello, un convenio vigente con una institución acreditada o con una institución cuyas condiciones de calidad institucionales se encuentren vigentes', '2.5.3.2.9.1'),
('22.5.3.2.9.2', 'Los programas del área de la salud que requieren formación en el campo asistencial estarán sujetos, en todo caso, a la evaluación de la relación docencia servicio acorde a la normatividad vigente', '2.5.3.2.9.2'),
('32.5.3.2.10.4', 'En la evaluación de ampliación del lugar de desarrollo, en lo que corresponda a la condición de profesores se reconocerán las diversas estrategias de regionalización y se tendrán en cuenta los mecanismos que la institución utilice para garantizar la presencia de profesores, en coherencia con los procesos formativos en cada lugar de desarrollo y para el cumplimiento de sus labores formativas, académicas, docentes, científicas, culturales y de extensión; siempre que se respeten las particularidades de la(s) modalidad(es) en la(s) que se ofrezca dicho programa', '2.5.3.2.10.4'),
('32.5.3.2.9.1', 'Los programas del área de la salud que requieren formación en el campo asistencial estarán sujetos, en todo caso, a la evaluación de la relación docencia servicio acorde a la normatividad vigente', '2.5.3.2.9.1'),
('42.5.3.2.10.4', 'En todo caso, la evaluación de las condiciones de calidad del programa se hará de manera independiente en cada lugar de desarrollo', '2.5.3.2.10.4'),
('52.5.3.2.10.4', 'Las instituciones que, al momento de la entrada en vigencia de la presente modificación, se encuentren ofreciendo programas en extensión, tendrán la posibilidad de solicitar la ampliación del lugar de desarrollo del programa del cual se originó la extensión conforme con el presente artículo y durante la vigencia del registro calificado del mismo. \\r\\nPara ello, la institución deberá surtir las etapas de prerradicación y radicación de solicitud de registro calificado respecto a todos los lugares de desarrollo del programa, con el fin de otorgar un registro calificado con las respectivas ampliaciones por un tiempo unificado de 7 años', '2.5.3.2.10.4');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla represenvisual
--

CREATE TABLE represenvisual (
  id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
  nombre varchar(100) NOT NULL
);

--
-- Volcado de datos para la tabla represenvisual
--

INSERT INTO represenvisual (nombre) VALUES
('Tabla'),
('Barras'),
('Bigotes'),
('Torta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla represenvisualporindicador
--

CREATE TABLE represenvisualporindicador (
  fkidindicador int NOT NULL,
  fkidrepresenvisual int NOT NULL,
  PRIMARY KEY(fkidindicador,fkidrepresenvisual)
);

--
-- Volcado de datos para la tabla represenvisualporindicador
--

INSERT INTO represenvisualporindicador (fkidindicador, fkidrepresenvisual) VALUES
(30, 2),
(31, 1),
(31, 2),
(31, 3),
(31, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla responsablesporindicador
--

CREATE TABLE responsablesporindicador (
  fkidresponsable varchar(50) NOT NULL,
  fkidindicador int NOT NULL,
  fechaasignacion DATETIME NOT NULL DEFAULT GETDATE(),
  PRIMARY KEY(fkidresponsable,fkidindicador)
);

--
-- Volcado de datos para la tabla responsablesporindicador
--

INSERT INTO responsablesporindicador (fkidresponsable, fkidindicador, fechaasignacion) VALUES
('1', 30, '2023-08-05 09:53:03'),
('1234567', 30, '2023-08-05 09:53:03'),
('17', 30, '2023-08-05 09:53:03'),
('17', 31, '2023-08-05 09:34:11'),
('2', 30, '2023-08-05 09:53:03'),
('2', 31, '2023-08-05 09:34:10'),
('3', 30, '2023-08-05 09:53:03'),
('3', 31, '2023-08-05 09:34:11'),
('300002023', 30, '2023-08-05 09:53:03'),
('300002023', 31, '2023-08-05 09:34:10'),
('71665', 30, '2023-08-05 09:53:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla resultadoindicador
--

CREATE TABLE resultadoindicador (
  id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
  resultado float NOT NULL,
  fechacalculo datetime NOT NULL,
  fkidindicador int NOT NULL
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla rol
--

CREATE TABLE rol (
  id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
  nombre varchar(100) NOT NULL
);

--
-- Volcado de datos para la tabla rol
--

INSERT INTO rol (nombre) VALUES
('admin'),
('Verificador'),
('Validador'),
('Administrativo'),
('invitado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla rol_usuario
--

CREATE TABLE rol_usuario (
  fkemail varchar(100) NOT NULL,
  fkidrol int NOT NULL,
  PRIMARY KEY(fkemail,fkidrol)
);

--
-- Volcado de datos para la tabla rol_usuario
--

INSERT INTO rol_usuario (fkemail, fkidrol) VALUES
('admin@empresa.com', 1),
('admin@empresa.com', 2),
('admin@empresa.com', 3),
('admin@empresa.com', 4),
('carlosarturo.castrocastro@gmail.com', 1),
('carlosarturo.castrocastro@gmail.com', 2),
('carlosarturo.castrocastro@gmail.com', 3),
('carlosarturo.castrocastro@gmail.com', 5),
('hugo@empresa.com', 5),
('paraborrar2@empresa.com', 1),
('paraborrar2@empresa.com', 2),
('paraborrar2@empresa.com', 3),
('paraborrar2@empresa.com', 4),
('paraborrar3@empresa.com', 2),
('paraborrar@empresa.com', 1),
('paraborrar@empresa.com', 2),
('paraborrar@empresa.com', 3),
('paraborrar@empresa.com', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla seccion
--

CREATE TABLE seccion (
  id varchar(2) NOT NULL PRIMARY KEY,
  nombre varchar(200) NOT NULL
);

--
-- Volcado de datos para la tabla seccion
--

INSERT INTO seccion (id, nombre) VALUES
('0', 'NA'),
('1', 'GENERALIDADES'),
('10', 'SITUACIONES ACERCA DEL REGISTRO CALIFICADO'),
('11', 'OTRAS DISPOSICIONES DEL REGISTRO CALIFICADO'),
('12', 'DISPOSICIONES TRANSITORIAS'),
('2', 'CARACTERÍSTICAS DEL REGISTRO CALIFICADO'),
('3', 'CONDICIONES DE CALIDAD'),
('4', 'CRÉDITOS ACADÉMICOS'),
('5', 'PROGRAMAS EN CONVENIO'),
('6', 'PROGRAMAS DE POSGRADO'),
('7', 'CICLOS PROPEDÉUTICOS'),
('8', 'TRÁMITE DE REGISTRO CALIFICADO'),
('9', 'PARTICULARIDADES DEL TRÁMITE DEL REGISTRO CALIFICADO POR PARTE DE INSTITUCIONES ACREDITADAS EN ALTA CALIDAD Y DE PROGRAMAS ACREDITADOS EN ALTA CALIDAD');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla sentido
--

CREATE TABLE sentido (
  id int NOT NULL IDENTITY(2,1) PRIMARY KEY,
  nombre varchar(200) NOT NULL
);

--
-- Volcado de datos para la tabla sentido
--

INSERT INTO sentido (nombre) VALUES
('Sentido 2'),
('Sentido 3'),
('Sentido 4'),
('Sentido 5');


--
-- Estructura de tabla para la tabla frecuencia
--

CREATE TABLE frecuencia (
  id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
  nombre varchar(200) NOT NULL
);

--
-- Volcado de datos para la tabla frecuencia
--

INSERT INTO frecuencia (nombre) VALUES
('frecuencia 1'),
('frecuencia 2'),
('frecuencia 3'),
('frecuencia 4'),
('frecuencia 5');
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla subseccion
--

CREATE TABLE subseccion (
  id varchar(2) NOT NULL PRIMARY KEY,
  nombre varchar(100) NOT NULL
);

--
-- Volcado de datos para la tabla subseccion
--

INSERT INTO subseccion (id, nombre) VALUES
('0', ''),
('13', 'Condiciones institucionales'),
('18', 'Etapa de prerradicación de solicitud de registro calificado'),
('23', 'Evaluación de condiciones de programa'),
('28', 'Etapa de radicación de solicitud de registro calificado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla tipoactor
--

CREATE TABLE tipoactor (
  id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
  nombre varchar(200) NOT NULL
);

--
-- Volcado de datos para la tabla tipoactor
--

INSERT INTO tipoactor (nombre) VALUES
('Estudiante'),
('Profesor'),
('Universidad'),
('Otro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla tipoindicador
--

CREATE TABLE tipoindicador (
  id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
  nombre varchar(200) NOT NULL
);

--
-- Volcado de datos para la tabla tipoindicador
--

INSERT INTO tipoindicador (nombre) VALUES
('Tipo1'),
('tipo2'),
('tipo3'),
('tipo4'),
('tipo5'),
('tipo6');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla unidadmedicion
--

CREATE TABLE unidadmedicion (
  id int NOT NULL IDENTITY(12,1) PRIMARY KEY,
  descripcion varchar(200) NOT NULL
);

--
-- Volcado de datos para la tabla unidadmedicion
--

INSERT INTO unidadmedicion (descripcion) VALUES
('Unidad 1'),
('Unidad 2'),
('Unidad 3'),
('Unidad 4'),
('Unidad 5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla usuario
--

CREATE TABLE usuario (
  email varchar(100) NOT NULL PRIMARY KEY,
  contrasena varchar(100) NOT NULL
);

--
-- Volcado de datos para la tabla usuario
--

INSERT INTO usuario (email, contrasena) VALUES
('admin@empresa.com', '1234567'),
('carlosarturo.castrocastro@gmail.com', 'e0bc614e4fd035a488619799853b075143deea596c477b8dc077e309c0fe42e9'),
('hugo@empresa.com', '1234567'),
('paraborrar2@empresa.com', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('paraborrar3@empresa.com', '8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414'),
('paraborrar@empresa.com', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla variable
--

CREATE TABLE variable (
  id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
  nombre varchar(200) NOT NULL,
  fechacreacion DATETIME NOT NULL DEFAULT GETDATE(),
  fkemailusuario varchar(100) NOT NULL
);

--
-- Volcado de datos para la tabla variable
--

INSERT INTO variable (nombre, fechacreacion, fkemailusuario) VALUES
('x', '2023-07-31 00:00:00', 'admin@empresa.com'),
('y', '2023-07-31 13:12:20', 'admin@empresa.com'),
('z', '2023-07-31 13:17:05', 'admin@empresa.com');


-- Estructura de tabla para la tabla variablesporindicador
--

CREATE TABLE variablesporindicador (
  id int NOT NULL IDENTITY(20,1) PRIMARY KEY,
  fkidvariable int NOT NULL,
  fkidindicador int NOT NULL,
  dato float NOT NULL,
  fkemailusuario varchar(100) NOT NULL,
  fechadato datetime NOT NULL
);

-- Volcado de datos para la tabla variablesporindicador
--
--

INSERT INTO variablesporindicador (fkidvariable, fkidindicador, dato, fkemailusuario, fechadato) VALUES
(1, 30, 10, 'admin@empresa.com', '2023-08-03 13:50:00'),
(1, 30, 20, 'admin@empresa.com', '2023-08-03 13:50:00'),
(1, 30, 30, 'admin@empresa.com', '2023-08-03 13:50:00');


--
-- Filtros para la tabla actor
--
ALTER TABLE actor
  ADD CONSTRAINT actor_ibfk_1 FOREIGN KEY (fkidtipoactor) REFERENCES tipoactor (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla articulo
--
ALTER TABLE articulo
  ADD CONSTRAINT articulo_ibfk_1 FOREIGN KEY (fkidseccion) REFERENCES seccion (id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE articulo
  ADD CONSTRAINT articulo_ibfk_2 FOREIGN KEY (fkidsubseccion) REFERENCES subseccion (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla fuentesporindicador
--
ALTER TABLE fuentesporindicador
  ADD CONSTRAINT cons_fkidfuente FOREIGN KEY (fkidfuente) REFERENCES fuente (id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE fuentesporindicador  
  ADD CONSTRAINT cons_fkidindicador1 FOREIGN KEY (fkidindicador) REFERENCES indicador (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla indicador
--
ALTER TABLE indicador
  ADD CONSTRAINT indicador_ibfk_1 FOREIGN KEY (fkidtipoindicador) REFERENCES tipoindicador (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE indicador
  ADD CONSTRAINT indicador_ibfk_2 FOREIGN KEY (fkidunidadmedicion) REFERENCES unidadmedicion (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE indicador
  ADD CONSTRAINT indicador_ibfk_3 FOREIGN KEY (fkidsentido) REFERENCES sentido (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE indicador
  ADD CONSTRAINT indicador_ibfk_frec FOREIGN KEY (fkidfrecuencia) REFERENCES frecuencia (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE indicador
  ADD CONSTRAINT indicador_ibfk_5 FOREIGN KEY (fkidarticulo) REFERENCES articulo (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE indicador
  ADD CONSTRAINT indicador_ibfk_6 FOREIGN KEY (fkidliteral) REFERENCES literal (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE indicador
  ADD CONSTRAINT indicador_ibfk_7 FOREIGN KEY (fkidnumeral) REFERENCES numeral (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE indicador
  ADD CONSTRAINT indicador_ibfk_8 FOREIGN KEY (fkidparagrafo) REFERENCES paragrafo (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla literal
--
ALTER TABLE literal
  ADD CONSTRAINT literal_ibfk_1 FOREIGN KEY (fkidarticulo) REFERENCES articulo (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla numeral
--
ALTER TABLE numeral
  ADD CONSTRAINT numeral_ibfk_1 FOREIGN KEY (fkidliteral) REFERENCES literal (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla paragrafo
--
ALTER TABLE paragrafo
  ADD CONSTRAINT paragrafo_ibfk_1 FOREIGN KEY (fkidarticulo) REFERENCES articulo (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla represenvisualporindicador
--
ALTER TABLE represenvisualporindicador
  ADD CONSTRAINT cons_fkidindicador2 FOREIGN KEY (fkidindicador) REFERENCES indicador (id) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE represenvisualporindicador
  ADD CONSTRAINT cons_fkidrepresenvisual FOREIGN KEY (fkidrepresenvisual) REFERENCES represenvisual (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla responsablesporindicador
--
ALTER TABLE responsablesporindicador
  ADD CONSTRAINT cons_fkidindicador1_1 FOREIGN KEY (fkidindicador) REFERENCES indicador (id) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE responsablesporindicador
  ADD CONSTRAINT cons_fkidresponsable FOREIGN KEY (fkidresponsable) REFERENCES actor (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla resultadoindicador
--
ALTER TABLE resultadoindicador
  ADD CONSTRAINT resultadoindicador_ibfk_1 FOREIGN KEY (fkidindicador) REFERENCES indicador (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla rol_usuario
--
ALTER TABLE rol_usuario
  ADD CONSTRAINT rol_usuario_ibfk_1 FOREIGN KEY (fkemail) REFERENCES usuario (email) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE rol_usuario
  ADD CONSTRAINT rol_usuario_ibfk_2 FOREIGN KEY (fkidrol) REFERENCES rol (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla variable
--
ALTER TABLE variable
  ADD CONSTRAINT cons_fkemailusuario3 FOREIGN KEY (fkemailusuario) REFERENCES usuario (email) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla variablesporindicador
--
ALTER TABLE variablesporindicador
  ADD CONSTRAINT cons_fkemailusuario4 FOREIGN KEY (fkemailusuario) REFERENCES usuario (email) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE variablesporindicador
  ADD CONSTRAINT cons_fkidindicador3 FOREIGN KEY (fkidindicador) REFERENCES indicador (id) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE variablesporindicador
  ADD CONSTRAINT cons_fkidvariable FOREIGN KEY (fkidvariable) REFERENCES variable (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

