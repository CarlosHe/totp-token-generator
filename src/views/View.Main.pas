unit View.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Samples.Gauges;

type
  TMainView = class(TForm)
    LabelTitle: TLabel;
    PanelTitle: TPanel;
    PanelSecretKey: TPanel;
    LabelSecretKey: TLabel;
    EditSecretKey: TEdit;
    PanelTokenPeriod: TPanel;
    LabelTokenPeriod: TLabel;
    EditTokenPeriod: TEdit;
    PanelNumberOfDigits: TPanel;
    LabelNumberOfDigits: TLabel;
    EditNumberOfDigits: TEdit;
    PanelRemainingTime: TPanel;
    GaugeRemainingTime: TGauge;
    LabeRemainingTime: TLabel;
    PanelToken: TPanel;
    EditToken: TEdit;
    TimerTOTPCalculator: TTimer;
    procedure TimerTOTPCalculatorTimer(Sender: TObject);
    procedure EditTokenPeriodChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

uses
  System.DateUtils,
  OTP;

{$R *.dfm}


procedure TMainView.EditTokenPeriodChange(Sender: TObject);
begin
  if StrToInt(TEdit(Sender).Text) < 1 then
    TEdit(Sender).Text := '1';
end;

procedure TMainView.TimerTOTPCalculatorTimer(Sender: TObject);
var
  LPeriod: Integer;
  LRemainingTime: Integer;
  LSecretKey: string;
  LTokenLength: Integer;
begin
  LPeriod := StrToInt(EditTokenPeriod.Text);
  LRemainingTime := LPeriod - DateTimeToUnix(Now(), False) mod LPeriod;
  LSecretKey := EditSecretKey.Text;
  LTokenLength := StrToInt(EditNumberOfDigits.Text);

  EditToken.Text := TOTPCalculator.New
    .SetSecret(LSecretKey)
    .SetKeyRegeneration(LPeriod)
    .SetLength(LTokenLength)
    .Calculate
    .ToString
    .PadLeft(LTokenLength, '0');

  GaugeRemainingTime.MaxValue := LPeriod;
  GaugeRemainingTime.Progress := LRemainingTime;

  LabeRemainingTime.Caption := Format('Updating in %d seconds', [LRemainingTime])
end;

end.
