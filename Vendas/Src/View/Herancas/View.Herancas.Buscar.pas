unit View.Herancas.Buscar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Menus;

type
  TViewHerancasBuscar = class(TForm)
    pnlTopo: TPanel;
    pnlGrid: TPanel;
    pnlBottom: TPanel;
    lblPesquisar: TLabel;
    edtPesquisar: TEdit;
    rdgFiltros: TRadioGroup;
    btnCadastrar: TBitBtn;
    btnFechar: TBitBtn;
    btnUtilizar: TBitBtn;
    dbgrd1: TDBGrid;
    pnlTotal: TPanel;
    lblTotal: TLabel;
    DS_: TDataSource;
    btnAlterar: TBitBtn;
    pm1: TPopupMenu;
    Atualizar1: TMenuItem;
    N1: TMenuItem;
    Excluir1: TMenuItem;
    procedure btnFecharClick(Sender: TObject);
    procedure btnUtilizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure dbgrd1KeyPress(Sender: TObject; var Key: Char);
    procedure dbgrd1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtPesquisarChange(Sender: TObject);
    procedure rdgFiltrosClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure Atualizar1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure BuscarDados; virtual;
    procedure ChamarTelaCadastrar(const AId: Integer = 0); virtual; abstract;
  public
    { Public declarations }
  end;

var
  ViewHerancasBuscar: TViewHerancasBuscar;

implementation

{$R *.dfm}

procedure TViewHerancasBuscar.Atualizar1Click(Sender: TObject);
begin
  Self.BuscarDados;
end;

procedure TViewHerancasBuscar.btnAlterarClick(Sender: TObject);
begin
  if(DS_.DataSet.IsEmpty)then
    raise Exception.Create('Selecione um registro');

  Self.ChamarTelaCadastrar(DS_.DataSet.FieldByName('ID').AsInteger);
end;

procedure TViewHerancasBuscar.btnCadastrarClick(Sender: TObject);
begin
  Self.ChamarTelaCadastrar;
end;

procedure TViewHerancasBuscar.btnFecharClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

procedure TViewHerancasBuscar.btnUtilizarClick(Sender: TObject);
begin
  if(DS_.DataSet.IsEmpty)then
    raise Exception.Create('Selecione um registro');

  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TViewHerancasBuscar.BuscarDados;
begin
  lblTotal.Caption := 'Registros localizados: 000000';
  if(DS_.DataSet.IsEmpty)then
    Exit;

  lblTotal.Caption := 'Registros localizados: ' + FormatFloat('000000', DS_.DataSet.RecordCount);
end;

procedure TViewHerancasBuscar.dbgrd1DblClick(Sender: TObject);
begin
  btnUtilizar.Click;
end;

procedure TViewHerancasBuscar.dbgrd1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if(not Odd(DS_.DataSet.RecNo))then
    dbgrd1.Canvas.Brush.Color := $00DDDDDD;

  dbgrd1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TViewHerancasBuscar.dbgrd1KeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13)then
    btnUtilizar.Click;
end;

procedure TViewHerancasBuscar.edtPesquisarChange(Sender: TObject);
begin
  Self.BuscarDados;
end;

procedure TViewHerancasBuscar.edtPesquisarKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case(Key)of
    VK_UP: DS_.DataSet.Prior;
    VK_DOWN: DS_.DataSet.Next;
  end;
end;

procedure TViewHerancasBuscar.edtPesquisarKeyPress(Sender: TObject;
  var Key: Char);
begin
  if(Key = #13) and (not DS_.DataSet.IsEmpty) then
    btnUtilizar.Click;
end;

procedure TViewHerancasBuscar.Excluir1Click(Sender: TObject);
begin
  if(DS_.DataSet.IsEmpty)then
    raise Exception.Create('Selecione um registro');

  if(Application.MessageBox(
    'Confirma exclusão deste registro?',
    'Confirma exclusão?', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) <> idYes)
  then
    Exit;

  DS_.DataSet.Delete;
  Self.BuscarDados;

end;

procedure TViewHerancasBuscar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case(Key)of

    VK_F4:
    begin
      if(ssAlt in Shift) then
        Key := 0;
    end;
    VK_ESCAPE: btnFechar.Click;
  end;
  if(Key in[VK_F1..VK_F12])then
  begin
    if(rdgFiltros.Items.Count >= Key - VK_F1)then
      rdgFiltros.ItemIndex := Key - VK_F1
  end;

end;

procedure TViewHerancasBuscar.FormShow(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  edtPesquisar.SetFocus;

end;

procedure TViewHerancasBuscar.rdgFiltrosClick(Sender: TObject);
begin
  edtPesquisar.SetFocus;
end;

end.
