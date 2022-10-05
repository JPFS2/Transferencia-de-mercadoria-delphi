inherited frmVPN: TfrmVPN
  Caption = 'VPN'
  ClientWidth = 447
  ExplicitWidth = 453
  ExplicitHeight = 436
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 447
    ExplicitWidth = 447
    object btnSair: TAdvGlowButton
      Left = 338
      Top = 2
      Width = 109
      Height = 35
      Hint = 'SAIR [ESC]'
      Anchors = [akTop, akRight]
      Caption = 'Sair [ESC]'
      ImageIndex = 6
      Images = Imagens
      HotImages = ImagensHot
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnSairClick
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
  end
  inherited Panel2: TPanel
    Width = 447
    ExplicitWidth = 447
    object DBGrid1: TDBGrid
      Left = 2
      Top = 2
      Width = 443
      Height = 343
      Align = alClient
      DataSource = frmPincipal.dscVPN
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'filial'
          Title.Caption = 'FILIAL'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ip'
          Title.Caption = 'ENDRE'#199'O IP'
          Width = 200
          Visible = True
        end>
    end
  end
  inherited pstatus: TAdvOfficeStatusBar
    Width = 447
    ExplicitWidth = 447
  end
  inherited ImagensHot: TcxImageList
    FormatVersion = 1
  end
  inherited Imagens: TcxImageList
    FormatVersion = 1
  end
end
