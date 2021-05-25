object DSServerMethods: TDSServerMethods
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 767
  Width = 1057
  object FDConnToDB: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'Database=localhost:C:\ProgramData\ScotServer\SCSDATA.FDB'
      'User_Name=sysdba'
      'password=masterkey')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 136
  end
  object FDQueryRollFormer: TFDQuery
    Connection = FDConnToDB
    UpdateOptions.AutoIncFields = 'ROLLFORMERID'
    SQL.Strings = (
      
        'select * from ROLLFORMER where (STATUSID=:STATUSID)and(SITEID=:S' +
        'IDEID) and ADDEDON between :STARTDATE and :ENDDATE')
    Left = 200
    Top = 48
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDQueryRFDateInfo: TFDQuery
    Connection = FDConnToDB
    SQL.Strings = (
      
        'select * from RFDATEINFO where (STATUSID=:STATUSID)and(SITEID=:S' +
        'IDEID) and ADDEDON between :STARTDATE and :ENDDATE')
    Left = 200
    Top = 128
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDQueryItemProduction: TFDQuery
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evItems, evRowsetSize, evCache, evUnidirectional, evCursorKind]
    FetchOptions.CursorKind = ckDefault
    FetchOptions.RowsetSize = 1000
    FetchOptions.Items = [fiBlobs, fiDetails]
    SQL.Strings = (
      
        'select * from ITEMPRODUCTION where (STATUSID=:STATUSID)and(SITEI' +
        'D=:SIDEID) and ADDEDON between :STARTDATE and :ENDDATE')
    Left = 360
    Top = 512
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDQueryAudit: TFDQuery
    Connection = FDConnToDB
    SQL.Strings = (
      
        'select * from AUDIT where (STATUSID=:STATUSID)and(SITEID=:SIDEID' +
        ') and ADDEDON between :STARTDATE and :ENDDATE')
    Left = 200
    Top = 216
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDQueryRFOperation: TFDQuery
    Connection = FDConnToDB
    FormatOptions.AssignedValues = [fvQuoteIdentifiers]
    SQL.Strings = (
      
        'select * from RFOPERATION where (STATUSID=:STATUSID)and(SITEID=:' +
        'SIDEID) and ADDEDON between :STARTDATE and :ENDDATE')
    Left = 200
    Top = 288
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDQueryJob: TFDQuery
    Connection = FDConnToDB
    UpdateOptions.AutoIncFields = 'JOBID'
    SQL.Strings = (
      
        'select * from JOB where (STATUSID=:STATUSID)and(SITEID=:SIDEID) ' +
        'and ADDEDON between :STARTDATE and :ENDDATE'
      '')
    Left = 360
    Top = 48
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDQueryJOBDETAIL: TFDQuery
    Connection = FDConnToDB
    SQL.Strings = (
      
        'select * from JOBDETAIL where (STATUSID=:STATUSID)and(SITEID=:SI' +
        'DEID) and ADDEDON between :STARTDATE and :ENDDATE')
    Left = 360
    Top = 128
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDQueryEP2File: TFDQuery
    Connection = FDConnToDB
    SQL.Strings = (
      
        'select  EP2FILEID,RFTYPEID,EP2FILE,STATUSID,JOBID,SITEID,ROLLFOR' +
        'MERID,TRANSFERTORFID1,TRANSFERTORFID2,TRANSFERTORFID3,TRANSFERTO' +
        'RFID4,TRANSFERTORFID5,TRANSFERTORFID6,ADDEDON,EP2TEXT from EP2FI' +
        'LE  where (STATUSID=:STATUSID)and(SITEID=:SIDEID) and ADDEDON be' +
        'tween :STARTDATE and :ENDDATE')
    Left = 360
    Top = 216
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDQueryFRAME: TFDQuery
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evItems, evRowsetSize, evCursorKind]
    FetchOptions.CursorKind = ckDefault
    FetchOptions.RowsetSize = 1000
    FetchOptions.Items = [fiBlobs, fiDetails]
    SQL.Strings = (
      
        'select * from FRAME  where (SITEID=:SIDEID) and ADDEDON between ' +
        ':STARTDATE and :ENDDATE')
    Left = 360
    Top = 352
    ParamData = <
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDQueryFRAMEENTITY: TFDQuery
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evItems, evRowsetSize, evCursorKind]
    FetchOptions.CursorKind = ckDefault
    FetchOptions.RowsetSize = 1000
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.AutoIncFields = 'FRAMEENTITYID'
    SQL.Strings = (
      
        'select * from FRAMEENTITY where (STATUSID=:STATUSID)and(SITEID=:' +
        'SIDEID) and ADDEDON between :STARTDATE and :ENDDATE')
    Left = 360
    Top = 432
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 360
    Top = 600
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 192
    Top = 600
  end
  object FDQueryPercentage: TFDQuery
    Connection = FDConnToDB
    Left = 200
    Top = 384
  end
  object FDEventAlerter1: TFDEventAlerter
    Connection = FDConnToDB
    Names.Strings = (
      'ITEMPRODUCTION')
    Left = 72
    Top = 240
  end
  object FDQueryEP2BLOB: TFDQuery
    Connection = FDConnToDB
    SQL.Strings = (
      
        'select  EP2FILEID, EP2TEXT from EP2FILE  where (EP2FILEID=:EP2FI' +
        'LEID)')
    Left = 776
    Top = 208
    ParamData = <
      item
        Name = 'EP2FILEID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FDQueryEP2FILEJOBID: TFDQuery
    Connection = FDConnToDB
    SQL.Strings = (
      
        'select  EP2FILEID,RFTYPEID,EP2FILE,STATUSID,JOBID,SITEID,ROLLFOR' +
        'MERID,TRANSFERTORFID1,TRANSFERTORFID2,TRANSFERTORFID3,TRANSFERTO' +
        'RFID4,TRANSFERTORFID5,TRANSFERTORFID6,ADDEDON,EP2TEXT from EP2FI' +
        'LE  where (STATUSID=:STATUSID)and(SITEID=:SIDEID) and (ADDEDON b' +
        'etween :STARTDATE and :ENDDATE) and (JOBID=:JOBID)')
    Left = 560
    Top = 216
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'JOBID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FDQueryFRAMEEP2FILEID: TFDQuery
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evItems, evRowsetSize, evCursorKind]
    FetchOptions.CursorKind = ckDefault
    FetchOptions.RowsetSize = 1000
    FetchOptions.Items = [fiBlobs, fiDetails]
    SQL.Strings = (
      
        'select * from FRAME  where (SITEID=:SIDEID) and (ADDEDON between' +
        ' :STARTDATE and :ENDDATE) AND (EP2FILEID=:EP2FILEID)')
    Left = 552
    Top = 352
    ParamData = <
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'EP2FILEID'
        ParamType = ptInput
      end>
  end
  object FDQueryFRAMEENTITYFRAMEID: TFDQuery
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evItems, evRowsetSize, evCursorKind]
    FetchOptions.CursorKind = ckDefault
    FetchOptions.RowsetSize = 1000
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.AutoIncFields = 'FRAMEENTITYID'
    SQL.Strings = (
      
        'select * from FRAMEENTITY where (STATUSID=:STATUSID)and(SITEID=:' +
        'SIDEID) and (ADDEDON between :STARTDATE and :ENDDATE) AND(FRAMEI' +
        'D=:FRAMEID)')
    Left = 552
    Top = 424
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'FRAMEID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FDQueryItemProductionFRAMEID: TFDQuery
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evItems, evRowsetSize, evCache, evUnidirectional, evCursorKind]
    FetchOptions.CursorKind = ckDefault
    FetchOptions.RowsetSize = 1000
    FetchOptions.Items = [fiBlobs, fiDetails]
    SQL.Strings = (
      
        'select * from ITEMPRODUCTION where (STATUSID=:STATUSID)and(SITEI' +
        'D=:SIDEID) and (ADDEDON between :STARTDATE and :ENDDATE) AND (FR' +
        'AMEID=:FRAMEID)')
    Left = 552
    Top = 512
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'FRAMEID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FDQueryEP2withoutBlob: TFDQuery
    Connection = FDConnToDB
    SQL.Strings = (
      
        'select  EP2FILEID,RFTYPEID,EP2FILE,STATUSID,JOBID,SITEID,ROLLFOR' +
        'MERID,TRANSFERTORFID1,TRANSFERTORFID2,TRANSFERTORFID3,TRANSFERTO' +
        'RFID4,TRANSFERTORFID5,TRANSFERTORFID6,ADDEDON from EP2FILE  wher' +
        'e (STATUSID=:STATUSID)and(SITEID=:SIDEID) and ADDEDON between :S' +
        'TARTDATE and :ENDDATE')
    Left = 360
    Top = 280
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftDateTime
        FDDataType = dtDateTime
        ParamType = ptInput
      end>
  end
  object FDQueryItemProductionROLLFORMERID: TFDQuery
    Connection = FDConnToDB
    SQL.Strings = (
      
        'Select ROLLFORMERID, ProducedON, sum(ITEMLENGTH) TOTALLENGTH fro' +
        'm (select ROLLFORMERID, ITEMLENGTH, extract(month from ADDEDON)|' +
        '|'#39'.'#39'||extract(day from ADDEDON) as ProducedON from ITEMPRODUCTIO' +
        'N where (STATUSID=:STATUSID)and(SITEID=:SIDEID) and (ADDEDON bet' +
        'ween :STARTDATE and :ENDDATE)) group by ROLLFORMERID, ProducedON')
    Left = 768
    Top = 512
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SIDEID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftTimeStamp
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftTimeStamp
        ParamType = ptInput
      end>
  end
  object FDQueryJobTransfer: TFDQuery
    Connection = FDConnToDB
    SQL.Strings = (
      
        'select * from JOBTRANSFER where (STATUSID=:STATUSID)and(SITEID=:' +
        'SIDEID) and ADDEDON between :STARTDATE and :ENDDATE')
    Left = 552
    Top = 48
    ParamData = <
      item
        Name = 'STATUSID'
        DataType = ftSmallint
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SIDEID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'STARTDATE'
        DataType = ftTimeStamp
        ParamType = ptInput
      end
      item
        Name = 'ENDDATE'
        DataType = ftTimeStamp
        ParamType = ptInput
      end>
  end
  object FDQueryEP2Assign: TFDQuery
    Connection = FDConnToDB
    SQL.Strings = (
      
        'select  EP2FILEID,JOBID,SITEID,ROLLFORMERID,TRANSFERTORFID1,TRAN' +
        'SFERTORFID2,TRANSFERTORFID3,TRANSFERTORFID4,TRANSFERTORFID5,TRAN' +
        'SFERTORFID6 from EP2FILE  where (SITEID=:SIDEID) and (JOBID=:JOB' +
        'ID)')
    Left = 776
    Top = 280
    ParamData = <
      item
        Name = 'SIDEID'
        DataType = ftSmallint
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'JOBID'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end>
  end
end
