const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const Gateway = require('./helpers/gateway');
const validate = require('./helpers/validate');

const fixtures = require('./fixtures/credential');

const errorSchema = require('./schemas/error');
const tokenSchema = require('./schemas/auth/token');

chai.should();
chai.use(chaiAsPromised);

describe('Auth tests', function() {

  describe('getToken', function() {

    it('should return error if client_id does not exists', function() {
      const credential = fixtures.invalidCredential();

      return Gateway.getToken(credential)
        .should.be.rejected
        .then(validate(errorSchema('Unknown client')));
    });

    it('should return error if client_id does not exists', function() {
      const credential = fixtures.invalidCredential();

      return Gateway.getToken(credential)
        .should.be.rejected
        .then(validate(errorSchema('Unknown client')));
    });

    it('should return token successfully', function() {
      const credential = fixtures.validCredential();

      return Gateway.getToken(credential)
      .should.be.fulfilled
      .then(validate(tokenSchema));
    });

    it('should return error if login has bad values', function() {
      const credential = fixtures.validLogin();

      credential.password = 'wrong';

      return Gateway.getToken(credential)
      .should.be.rejected
      .then(validate(errorSchema('Invalid credentials')));
    });

    it('should return token successfully with valid login', function() {
      const credential = fixtures.validLogin();

      return Gateway.getToken(credential)
      .should.be.fulfilled
      .then(validate(tokenSchema));
    });
  });
});
