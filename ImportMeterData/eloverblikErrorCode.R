eloverblikErrorCode <-
  list(
    General = c(
      NoError = 10000,
      WrongNumberOfArguments = 10001,
      NoCprConsent = 10007
    ),
    MeteringPoint = c(
      WrongMeteringPointIdOrWebAccessCode = 20000,
      MeteringPointBlocked = 20001,
      MeteringPointRelationAlreadyExist = 20002,
      MeteringPointIdNot18CharsLong = 20003,
      MeteringPointAliasTooLong = 20005,
      WebAccessCodeNot8CharsLong = 20006,
      WebAccessCodeContainsIllegalChars = 20007,
      MeteringPointNotFound = 20008,
      MeteringPointIsChild = 20009,
      RelationNotFound = 20010,
      UnknownError = 20011,
      Unauthorized = 20012
    ),
    MeterData = c(
      FromDateIsGreaterThanToday = 30000,
      FromDateIsGreaterThanToDate = 30001,
      ToDateCantBeEqualToFromDate = 30002,
      ToDateIsGreaterThanToday = 30003,
      InvalidDateFormat = 30004,
      InvalidRequestParameters = 30005,
      AccessToMeterPointDenied = 30006,
      NoMeterPointDataAviliable = 30007,
      RequestedAggregationUnavaliable = 30008,
      MaximumMeterPointsExceeded = 30009,
      InvalidMeterpointID = 30010,
      InternalServerError = 30011,
      DateNotCoveredByPowerOfAttorney = 30012
    ),
    Token = c(
      WrongTokenType = 50000,
      TokenNotValid = 50001,
      ErrorCreatingToken = 50002,
      TokenRegistrationFailed = 50003,
      TokenAlreadyActive = 50004,
      TokenAlreadyDeactivaed = 50005
    ),
    ThirdParty = c(
      ThirdPartyNotFound = 60000
      )
  )
