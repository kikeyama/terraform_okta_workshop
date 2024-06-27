function(accessToken, ctx, cb) {
  request.get('https://userinfo.yahooapis.jp/yconnect/v2/attribute', {
    headers: {
      'Authorization': 'Bearer ' + accessToken
    }
  }, function(e, r, b) {
    if (e) return cb(e);
    if (r.statusCode !== 200) return cb(new Error('StatusCode: ' + r.statusCode));
    var profile = JSON.parse(b);
    cb(null, {
      user_id: profile.sub,
      email: profile.email,
      email_verified: profile.email_verified,
      name: profile.name,
      given_name: profile.given_name,
      family_name: profile.family_name,
      nickname: profile.nickname,
      picture: profile.picture,
    });
  });
}