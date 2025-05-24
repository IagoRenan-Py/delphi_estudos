unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Winapi.ShellAPI;

type
  TViewPrincipal = class(TForm)
    ViewPrincipalMainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Movimentaes1: TMenuItem;
    Financeiro1: TMenuItem;
    Fiscal1: TMenuItem;
    Empresas1: TMenuItem;
    Cidades1: TMenuItem;
    Pessoas1: TMenuItem;
    N1: TMenuItem;
    Subgruposdeprodutos1: TMenuItem;
    Produtos1: TMenuItem;
    Vendas1: TMenuItem;
    ContasaReceber1: TMenuItem;
    Configuraes1: TMenuItem;
    NFCe1: TMenuItem;
    pnlLogoBack: TPanel;
    pnl2: TPanel;
    img1: TImage;
    pnl3: TPanel;
    lblYoutube: TLabel;
    lblGitHub: TLabel;
    procedure lblYoutubeClick(Sender: TObject);
    procedure lblYoutubeMouseEnter(Sender: TObject);
    procedure lblYoutubeMouseLeave(Sender: TObject);
    procedure Cidades1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.dfm}

uses
  View.Cidades.Buscar;

procedure TViewPrincipal.Cidades1Click(Sender: TObject);
begin
  ViewCidadesBuscar := TViewCidadesBuscar.Create(nil);

  try
    ViewCidadesBuscar.ShowModal;
  finally
    FreeAndNil(ViewCidadesBuscar);
  end;

end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TViewPrincipal.lblYoutubeClick(Sender: TObject);
begin
  ShellExecute(0, nil, PChar(TLabel(Sender).Caption), '', '', SW_SHOWNORMAL);
end;

procedure TViewPrincipal.lblYoutubeMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clRed;
end;

procedure TViewPrincipal.lblYoutubeMouseLeave(Sender: TObject);
begin
    TLabel(Sender).Font.Color := clWindowText;
end;

end.
