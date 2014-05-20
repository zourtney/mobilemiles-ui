describe('Properties', function() {
  var props;

  beforeEach(module('mobilemilesConst'));

  beforeEach(inject(function(properties) {
    props = properties;
  }));

  it('should contain a valid object', function() {
    expect(props).toBeDefined();
  });

  it('should contain a BASE_URL property', function() {
    expect(props.BASE_URL).toBeDefined();
  });

  it('should contain a FIRST_PAGE property', function() {
    expect(props.FIRST_PAGE).toBeDefined()
    expect(props.FIRST_PAGE).toContain('/');
  });
});
