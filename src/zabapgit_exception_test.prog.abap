REPORT zabapgit_exception_test.

FORM run RAISING zcx_abapgit_exception.
  zcx_abapgit_exception=>raise( 'Test' ).
ENDFORM.

START-OF-SELECTION.

  DATA error TYPE REF TO zcx_abapgit_exception.

  TRY.
      PERFORM run.
    CATCH zcx_abapgit_exception INTO error.
      " Display variable ERROR in the debugger and then "Show trigger location"
      BREAK-POINT.
  ENDTRY.
