CLASS zcl_rap_eml_gp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rap_eml_gp IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**    Forma de leer toda la tabla con un id especifico, solo se mostrara el ID ya que eso fue solo lo que se indico
*    READ ENTITIES OF zi_rap_travel_gp
*    ENTITY travel
*    FROM VALUE #( ( TravelUUID = '07E24B04B70732401900B2DAAD1F2440' ) )
*    RESULT DATA(Travels).
*
*    " Step 2 - READ con campos específicos , en la consolo veras todos los campos pero solo veras llenos los que se indican en fields
*    READ ENTITIES OF ZI_RAP_Travel_gp
*   ENTITY travel
*   FIELDS ( AgencyID CustomerID )
*   WITH VALUE #( ( TravelUUID = '07E24B04B70732401900B2DAAD1F2440' ) )
*   RESULT DATA(travels1).
*
**   Step 3 LEER TODOS LOS CAMPOS SEGUN UN ID
*    READ ENTITIES OF ZI_RAP_Travel_gp
*    ENTITY travel
*    ALL FIELDS
*    WITH VALUE #( ( TravelUUID = '07E24B04B70732401900B2DAAD1F2440' ) )
*    RESULT DATA(travels2).
*
*
**  Step 4 leer los booking asociados a un travel , es la manera mas optima para leer asociaciones , es como un inner join pero con más ventajas en RAP
*
*    READ ENTITIES OF ZI_RAP_Travel_gp
*    ENTITY travel BY \_Booking
*    ALL FIELDS WITH VALUE #( ( TravelUUID = '07E24B04B70732401900B2DAAD1F2440' ) )
*    RESULT DATA(bookings).
*
** step 5  atajar errores en la lectura read Unsuccessful READ
*    READ ENTITIES OF ZI_RAP_Travel_gp
*    ENTITY travel
*    ALL FIELDS WITH VALUE #( ( TravelUUID = '11111111111111111111111111111111' ) )
*    RESULT DATA(travels3)
*    FAILED DATA(failed)
*    REPORTED DATA(reported).


* " step 6 - MODIFY Update
*     MODIFY ENTITIES OF ZI_RAP_Travel_gp
*       ENTITY travel
*         UPDATE
*           SET FIELDS WITH VALUE
*             #( ( TravelUUID  = '07E24B04B70732401900B2DAAD1F2440'
*                  Description = 'Que suene vnz' ) )
*
*      FAILED DATA(failed)
*      REPORTED DATA(reported).
*
*      " step 6b - Commit Entities
*     COMMIT ENTITIES
*       RESPONSE OF ZI_RAP_Travel_gp
*       FAILED     DATA(failed_commit)
*       REPORTED   DATA(reported_commit).
*

" step 7 - MODIFY Create Create a new Travel instance
*MODIFY ENTITIES OF ZI_RAP_Travel_gp
*ENTITY travel
*CREATE
*SET FIELDS WITH VALUE #( (
*%cid  = 'MycontentID_1'
*AgencyID = '70012'
*CustomerID = '14'
*BeginDate = cl_abap_context_info=>get_system_date( )
*EndDate =  cl_abap_context_info=>get_system_date( ) + 10
*Description = 'La merma'
*
* ) )
*
*MAPPED data(mapped)
*FAILED data(failed)
*REPORTED data(reported).
*
*out->write( mapped-travel ).
*
*COMMIT ENTITIES
*RESPONSE OF ZI_RAP_Travel_gp
*FAILED DATA(FAILED_COMIT)
*REPORTED DATA(REPORTED_COMMIT).
*
*
*       out->write( 'Create done' ).

MODIFY ENTITIES OF ZI_RAP_Travel_GP
      ENTITY travel
        DELETE FROM
          VALUE
            #( ( TravelUUID  = '06E4D4F39BD01EDFBF8CC6FE04C098F4' ) )

     FAILED DATA(failed)
     REPORTED DATA(reported).

    COMMIT ENTITIES
      RESPONSE OF ZI_RAP_Travel_GP
      FAILED     DATA(failed_commit)
      REPORTED   DATA(reported_commit).

    out->write( 'Delete done' ).




*    out->write( Travels ).
*    out->write( travels1 ).
*    out->write( travels2 ).
*    out->write( bookings ).
*    out->write( travels3 ). " Tabla vacía porque el UUID no existe
*    out->write( failed ). " No soportado en consola, pero lo vemos en Debugger
*    out->write( reported ). " No soportado en consola, pero lo vemos en Debugger
*    out->write( 'Update done' ).





  ENDMETHOD.
ENDCLASS.
