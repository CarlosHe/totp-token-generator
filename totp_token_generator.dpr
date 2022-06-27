program totp_token_generator;

uses
  Vcl.Forms,
  View.Main in 'src\views\View.Main.pas' {MainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
