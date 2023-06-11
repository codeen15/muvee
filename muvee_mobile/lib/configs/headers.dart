headerWithoutToken() => {
      'Accept': 'application/json',
      'Content-type': 'application/json',
    };

headerWithToken(String token) => {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Token $token',
    };
