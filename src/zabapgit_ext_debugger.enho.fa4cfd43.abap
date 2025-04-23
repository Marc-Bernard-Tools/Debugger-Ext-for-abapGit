"Name: \TY:CL_TPDA_CONTROL\IN:IF_TPDA_CONTROL\ME:GET_EXCOBJ_SRCINFO\SE:END\EI
ENHANCEMENT 0 ZABAPGIT_EXT_DEBUGGER.

  " The kernel method above always returns the position of the RAISE EXCEPTION statement.
  " Unfortunately, method GET_SOURCE_POSITION of the exception is not used here *sigh*
  "
  " For custom exceptions that use static methods to raise the exception this points to the
  " wrong position. Instead, we get the "source position" attribute of the exception
  " (MS_SRC_INFO or SRC_INFO).
  "
  " PS: Decoding attributes of type table (like MT_CALLSTACK) is quite complex so we
  " rely on a structure (which still requires some hex conversion).

  CONSTANTS version TYPE string VALUE '1.0.0'.

  DATA:
    attrtab   TYPE tpda_sys_symbattrtyp_d,
    attr      LIKE LINE OF attrtab,
    refstruct TYPE REF TO tpda_sys_symbstruct.

  FIELD-SYMBOLS <x> TYPE x.

  TRY.
      get_symb_objattr(
        EXPORTING
          toolid       = 0
          instancename = excobjname
          filter       = ''
        IMPORTING
          attrtab      = attrtab ).

      READ TABLE attrtab INTO attr WITH KEY attr_name COMPONENTS name = 'MS_SRC_INFO'.
      IF sy-subrc <> 0.
        READ TABLE attrtab INTO attr WITH KEY attr_name COMPONENTS name = 'SRC_INFO'.
      ENDIF.
      IF sy-subrc = 0.
        refstruct ?= attr-symbquick-quickdata.
        ASSIGN src_info-program TO <x> CASTING.
        <x> = refstruct->xvalstring+0(80). "char40
        ASSIGN src_info-include TO <x> CASTING.
        <x> = refstruct->xvalstring+80(80). "char40
        ASSIGN src_info-line TO <x> CASTING.
        <x> = refstruct->xvalstring+160(*). "int4
      ENDIF.

    CATCH cx_root ##NO_HANDLER.
  ENDTRY.

ENDENHANCEMENT.
