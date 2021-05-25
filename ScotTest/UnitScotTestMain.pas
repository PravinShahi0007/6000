unit UnitScotTestMain;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TScotTestObject = class(TObject)
  private
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure Test1;
    // Test with TestCase Attribute to supply parameters.
    [Test]
    [TestCase('TestA','1,2')]
    [TestCase('TestB','3,4')]
    procedure Test2(const AValue1 : Integer;const AValue2 : Integer);
  end;

implementation

uses SysUtils, Data.FireDACJSONReflect;

procedure TScotTestObject.Setup;
begin
end;

procedure TScotTestObject.TearDown;
begin
end;

procedure TScotTestObject.Test1;
begin
end;

procedure TScotTestObject.Test2(const AValue1 : Integer;const AValue2 : Integer);
begin
end;

initialization
  TDUnitX.RegisterTestFixture(TScotTestObject);
end.
