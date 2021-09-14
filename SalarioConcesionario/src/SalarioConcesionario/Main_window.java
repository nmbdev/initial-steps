package SalarioConcesionario;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.regex.Pattern;

import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.SwingConstants;
import javax.swing.border.Border;
import javax.swing.border.CompoundBorder;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;


public class Main_window extends JFrame implements ActionListener{
    private JFrame      window;
    private JPanel      mainPanel;
    private JPanel      barPanel;
    private JPanel      westBarPanel;
    private JPanel      centralBarPanel;
    private JPanel      centralPanel;
    private JPanel      eastBarPanel;
    private JPanel      panel1;
    private JPanel      panel2;
    private JLabel      titleWindowLabel;
    private JLabel      label1;
    private JLabel      label2;
    private JLabel      label3;
    private JLabel      label4;
    private JTextField  textField1;
    private JTextField  textField2;
    private JButton     backWindowControlButton;
    private JButton     minimizeWindowControlButton;
    private JButton     maximizeRestoreWindowControlButton;
    private JButton     closeWindowControlButton;
    private JButton     button1;
    private JButton     button2;
    private JButton     button3;
    
    private final static Font FONT              = new Font("Corbel", Font.PLAIN, 30);
    private static final GridBagConstraints GBC = new GridBagConstraints();
    private static final Toolkit TOOLKIT        = Toolkit.getDefaultToolkit();
    private static final String PATTERN_NAME    = "^[\\p{L} .'-]+$";
    private static final String CURRENCY_FORMAT = "$%,.2f";
        
    private static final String TEXT_TITLE_MAIN_WINDOW  = "Main_window";
    private static final String TEXT_TITLE_LIQ_PR_SS    = "Liquidación de Prestaciones y Seguridad Social";
    private static final String TEXT_TITLE_LIQ_NM_PF    = "Liquidación de Nómina y Parafiscales";
    private static final String TEXT_LABEL_CONT_EMP     = "Contratar Empleado";
    private static final String TEXT_LABEL_NAME         = "Nombre";
    private static final String TEXT_LABEL_WAGE         = "Salario";
    private static final String TEXT_LABEL_ING_EMP      = "Ingresar Empleado";
    private static final String TEXT_LABEL_VALUE        = "Valor :  ";
    private static final String TEXT_LABEL_VALUE_NUM    = "0.00";
    private static final String TEXT_BUTTON_CONTRATAR   = "Contratar";
    private static final String TEXT_BUTTON_LIQ_PR_SS   = "Liquidación Prestaciones y Seguridad";
    private static final String TEXT_BUTTON_LIQ_NM_PF   = "Liquidación Nómina y Parafiscales";
    private static final String TEXT_BUTTON_LIQ_PREST   = "Liquidar Prestaciones Sociales";
    private static final String TEXT_BUTTON_LIQ_SEGSO   = "Liquidar Seguridad Social";
    private static final String TEXT_BUTTON_LIQ_NOMIN   = "Liquidar Nómina";
    private static final String TEXT_BUTTON_LIQ_PARAF   = "Liquidar Parafiscales";
    
    private double value = 0.0;
    private Banco banco;
    
    public Main_window(){
        init();     
        banco = new Banco();
    }
    
    /*INIT GUI==================================================================*/
    
    private void init() {
        initWindow(TEXT_TITLE_MAIN_WINDOW, 70, true);
        initMainPanel();
        initBarPanel();
        initCentralPanel();
        initComponents();
        initComponentListener();        
        
        presetViewMainWindow();
        window.add(mainPanel); 
        window.setVisible(true);        
    }
        
    private void initWindow(String title, int ratio, boolean resizable){
        window = new JFrame();
        
        try {
            windowSize(ratio);
            window.setTitle(title);
            window.setUndecorated(true);
            window.setLocationRelativeTo(null);
            window.setResizable(resizable);
            window.setDefaultCloseOperation(window.EXIT_ON_CLOSE);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e);
        }
    }
    
    private int[] getScreenSize(){
        int[] dimensionXY = {1000, 600};
        
        try {
            Dimension dimension = Main_window.TOOLKIT.getScreenSize();
            dimensionXY[0] = (int) dimension.getWidth();
            dimensionXY[1] = (int) dimension.getHeight();            
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e);
        }        
        
        return dimensionXY;
    }
    
    private void windowSize(int ratio) {
        int widthScreen;
        int heightScreen;
        int widthFrame;
        int heightFrame;
        
        try {
            widthScreen     = getScreenSize()[0];
            heightScreen    = getScreenSize()[1];
            widthFrame      = (int) (widthScreen * ratio/100);
            heightFrame     = (int) (heightScreen * ratio/100);
            
            window.setSize(widthFrame, heightFrame);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e);
        }
    }
    
    private void initMainPanel() {
        mainPanel = new JPanel();
        mainPanel.setLayout(new BorderLayout(10, 10));
        mainPanel.setBackground(Color.WHITE);
    }
    
    private void initBarPanel() {
        backWindowControlButton             = createBarButton(" < ",    "Atrás");
        minimizeWindowControlButton         = createBarButton(" - ",    "Minimizar");
        maximizeRestoreWindowControlButton  = createBarButton(" [] ",   "Maximizar");
        closeWindowControlButton            = createBarButton(" X ",    "Cerrar");
        
        titleWindowLabel = new JLabel(TEXT_TITLE_MAIN_WINDOW);
        titleWindowLabel.setForeground(Color.WHITE);
        titleWindowLabel.setHorizontalAlignment(JLabel.CENTER);

        //BAR
        GridBagLayout barLayout = new GridBagLayout();
        
        barPanel = new JPanel();
        barPanel.setLayout(barLayout);
        barPanel.setBackground(Color.BLACK);
        
        //WEST BAR
        GridBagLayout westBarPanelLayout = new GridBagLayout();
        
        westBarPanel = new JPanel();
        westBarPanel.setLayout(westBarPanelLayout);
        westBarPanel.setOpaque(false);
        
        //CENTER BAR
        GridLayout centralBarPanelLayout = new GridLayout(1, 1);
        
        centralBarPanel = new JPanel();
        centralBarPanel.setLayout(centralBarPanelLayout);
        centralBarPanel.setOpaque(false);
        
        //EAST BAR
        GridLayout eastBarPanelLayout = new GridLayout(1, 3);
        
        eastBarPanel = new JPanel();
        eastBarPanel.setLayout(eastBarPanelLayout);
        eastBarPanel.setSize(90, 30);
        eastBarPanel.setOpaque(false);

        //WEST BUTTONS
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(0, 0, 0, 0);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;        
        westBarPanel.add(backWindowControlButton, GBC);  
        
        //CENTER LABEL
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.HORIZONTAL;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(0, 0, 0, 0);
        GBC.anchor = GridBagConstraints.CENTER;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        centralBarPanel.add(titleWindowLabel, GBC);
        
        //EAST BUTTONS
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(0, 0, 0, 0);
        GBC.anchor = GridBagConstraints.CENTER;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        eastBarPanel.add(minimizeWindowControlButton, GBC);
        
        GBC.gridx = 1;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(0, 0, 0, 0);
        GBC.anchor = GridBagConstraints.CENTER;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        eastBarPanel.add(maximizeRestoreWindowControlButton, GBC);
        
        GBC.gridx = 2;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(0, 0, 0, 0);
        GBC.anchor = GridBagConstraints.CENTER;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        eastBarPanel.add(closeWindowControlButton, GBC);
        
        //WEST PANEL
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 4;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(0, 0, 0, 0);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.3;
        GBC.weighty = 0.0;
        barPanel.add(westBarPanel, GBC);
        
        //CENTER PANEL
        GBC.gridx = 4;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.HORIZONTAL;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(10, 10, 10, 10);
        GBC.anchor = GridBagConstraints.CENTER;
        GBC.weightx = 0.6;
        GBC.weighty = 0.0;
        barPanel.add(titleWindowLabel, GBC);
        
        //EAST PANEL
        GBC.gridx = 5;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 4;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(0, 0, 0, 0);
        GBC.anchor = GridBagConstraints.EAST;
        GBC.weightx = 0.15;
        GBC.weighty = 0.0;
        barPanel.add(eastBarPanel, GBC);
        
        mainPanel.add(barPanel, BorderLayout.NORTH);
    }

    private JButton createBarButton(String text, String tipText){
        JButton button = new JButton(text);
        
        button.setToolTipText(tipText);
        button.setSize(250, 250);
        button.setOpaque(false);
        button.setFocusPainted(false);
        //button.setBorderPainted(false);
        button.setContentAreaFilled(false);
        button.setForeground(Color.WHITE);
        
        return button;
    }
    
    private void initCentralPanel() {
        GridBagLayout centralPanelLayout = new GridBagLayout();
        
        centralPanel = new JPanel();
        centralPanel.setLayout(centralPanelLayout);
        centralPanel.setBackground(Color.WHITE);
        
        GridBagLayout panel1Layout = new GridBagLayout();
        
        panel1 = new JPanel();        
        panel1.setLayout(panel1Layout);
        panel1.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        panel1.setBackground(Color.WHITE);
        
        GridBagLayout panel2Layout = new GridBagLayout();
        
        panel2 = new JPanel();
        panel2.setLayout(panel2Layout);
        panel2.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        panel2.setBackground(Color.WHITE);
        
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 10, 5);
        GBC.anchor = GridBagConstraints.CENTER;
        GBC.weightx = 0.5;
        GBC.weighty = 1.0;
        centralPanel.add(panel1, GBC);
        
        GBC.gridx = 1;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(10, 5, 10, 10);
        GBC.anchor = GridBagConstraints.CENTER;
        GBC.weightx = 0.5;
        GBC.weighty = 1.0;
        centralPanel.add(panel2, GBC);
        
        mainPanel.add(centralPanel, BorderLayout.CENTER);
    }
    
    private void initComponents() {
        label1 = new JLabel("LABEL 1");
        label1.setForeground(Color.WHITE);
        label2 = new JLabel("LABEL 2");
        label3 = new JLabel("LABEL 3");
        label4 = new JLabel("LABEL 4");
        
        textField1 = new JTextField("TEXT FIELD 1");
        textField2 = new JTextField("TEXT FIELD 2");
        
        button1 = getButtonStylized();
        button2 = getButtonStylized();
        button3 = getButtonStylized();
        
    }
    
    private JButton getButtonStylized(){
        JButton button = new JButton();
        
        Border borderOut = new LineBorder(Color.BLACK);
        Border borderIn = new EmptyBorder(5, 15, 5, 15);
        Border border = new CompoundBorder(borderOut, borderIn);
        
        button.setForeground(Color.WHITE);
        button.setBackground(Color.GRAY);
        button.setBorder(border);
        button.setFocusPainted(false);
        
        return button;
    }
    
    /*PRESETS===================================================================*/
    
    private void presetViewMainWindow(){
        //STAR VALUES
        titleWindowLabel.setText(TEXT_TITLE_MAIN_WINDOW);
        
        label1.setText(TEXT_LABEL_CONT_EMP);
        label1.setHorizontalAlignment(SwingConstants.CENTER);
        label1.setForeground(Color.WHITE);
        label2.setText(TEXT_LABEL_NAME);
        label2.setHorizontalAlignment(SwingConstants.LEFT);
        label2.setForeground(Color.BLACK);
        label3.setText(TEXT_LABEL_WAGE);
        label3.setHorizontalAlignment(SwingConstants.LEFT);
        label3.setForeground(Color.BLACK);
        
        textField1.setText(null);
        textField2.setText(null);
        
        button1.setText(TEXT_BUTTON_CONTRATAR);
        button2.setText(TEXT_BUTTON_LIQ_PR_SS);        
        button3.setText(TEXT_BUTTON_LIQ_NM_PF);
        
        //BAR PANEL
        //backWindowControlButton.hide();
        backWindowControlButton.setVisible(false);
        
        GBC.gridx = 4;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.HORIZONTAL;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(10, 10, 10, 10);
        GBC.anchor = GridBagConstraints.CENTER;
        GBC.weightx = 0.4;
        GBC.weighty = 0.0;
        barPanel.add(titleWindowLabel, GBC);
        
        //CENTRAL PANEL
        centralPanel.setBackground(Color.WHITE);
        
        panel1.removeAll();
        panel1.setOpaque(true);
        panel1.setBackground(Color.lightGray);
        panel2.removeAll();
        panel2.setOpaque(false);
        panel2.setBackground(Color.WHITE);
        
        //PANEL 1 in CENTRAL PANEL
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(50, 50, 10, 5);
        GBC.anchor = GridBagConstraints.NORTHWEST;
        GBC.weightx = 0.6;
        GBC.weighty = 1.0;
        centralPanel.add(panel1, GBC);
        
        //PANEL 2 in CENTRAL PANEL
        GBC.gridx = 1;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(20, 5, 10, 30);
        GBC.anchor = GridBagConstraints.NORTHEAST;
        GBC.weightx = 0.4;
        GBC.weighty = 1.0;
        centralPanel.add(panel2, GBC);
        
        //LOCATE COMPONENTS
        //COMPONENTS in PANEL 1
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 3;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 150;
        GBC.ipady = 10;
        GBC.insets = new Insets(0, 30, 10, 30);
        GBC.anchor = GridBagConstraints.NORTH;
        GBC.weightx = 1.0;
        GBC.weighty = 0.0;
        panel1.add(label1, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 3, 10);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(label2, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 2;
        GBC.gridheight = 1;
        GBC.gridwidth = 3;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(0, 10, 10, 50);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(textField1, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 3;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 3, 10);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(label3, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 4;
        GBC.gridheight = 1;
        GBC.gridwidth = 3;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(0, 10, 10, 50);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(textField2, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 6;
        GBC.gridheight = 5;
        GBC.gridwidth = 3;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 100;
        GBC.ipady = 10;
        GBC.insets = new Insets(30, 10, 100, 10);
        GBC.anchor = GridBagConstraints.NORTH;
        GBC.weightx = 0.7;
        GBC.weighty = 0.0;
        panel1.add(button1, GBC);
        
        //COMPONENTS in PANEL 2
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 50;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 50, 10);
        GBC.anchor = GridBagConstraints.NORTHEAST;
        GBC.weightx = 1.0;
        GBC.weighty = 0.0;
        panel2.add(button2, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 50;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 300, 10);
        GBC.anchor = GridBagConstraints.NORTHEAST;
        GBC.weightx = 1.0;
        GBC.weighty = 0.0;
        panel2.add(button3, GBC);
        
    }
        
    private void presetViewPrestacionesYSeguridadSocial(){
        //STAR VALUES
        //currentView = TEXT_TITLE_LIQ_PR_SS;
        titleWindowLabel.setText(TEXT_TITLE_LIQ_PR_SS);
        
        label1.setText(TEXT_LABEL_ING_EMP);
        label1.setHorizontalAlignment(SwingConstants.LEFT);
        label1.setForeground(Color.BLACK);
        label2.setText(TEXT_LABEL_VALUE + TEXT_LABEL_VALUE_NUM);
        label2.setHorizontalAlignment(SwingConstants.LEFT);
        label2.setForeground(Color.BLACK);
        label3.setText(TEXT_LABEL_ING_EMP);
        label3.setHorizontalAlignment(SwingConstants.LEFT);
        label3.setForeground(Color.BLACK);
        label4.setText(TEXT_LABEL_VALUE + TEXT_LABEL_VALUE_NUM);
        label4.setHorizontalAlignment(SwingConstants.LEFT);
        label4.setForeground(Color.BLACK);
        
        textField1.setText(null);
        textField2.setText(null);
        
        button1.setText(TEXT_BUTTON_LIQ_PREST);
        button2.setText(TEXT_BUTTON_LIQ_SEGSO);        
        
        //BAR PANEL
        //backWindowControlButton.hide();
        backWindowControlButton.setVisible(true);
        
        GBC.gridx = 4;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.HORIZONTAL;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(10, 10, 10, 10);
        GBC.anchor = GridBagConstraints.CENTER;
        GBC.weightx = 0.6;
        GBC.weighty = 0.0;
        barPanel.add(titleWindowLabel, GBC);
        
        //CENTRAL PANEL
        centralPanel.setBackground(Color.WHITE);
        //Borrar fondo
        panel1.removeAll();
        panel1.setOpaque(false);
        panel1.setBackground(Color.WHITE);
        panel2.removeAll();
        panel2.setOpaque(false);
        panel2.setBackground(Color.WHITE);
        
        //PANEL 1 in CENTRAL PANEL
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 10, 10);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 1.0;
        GBC.weighty = 0.5;
        centralPanel.add(panel1, GBC);
        
        //PANEL 2 in CENTRAL PANEL
        GBC.gridx = 0;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 10, 10);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 1.0;
        GBC.weighty = 0.5;
        centralPanel.add(panel2, GBC);
        
        //LOCATE COMPONENTS
        //COMPONENTS in PANEL 1
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 3, 200);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(label1, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(5, 10, 10, 10);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(textField1, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 2;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 10, 0);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(label2, GBC);
                
        GBC.gridx = 1;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 100, 10, 10);
        GBC.anchor = GridBagConstraints.EAST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(button1, GBC);
        
        //COMPONENTS in PANEL 2
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 3, 200);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel2.add(label3, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(5, 10, 10, 10);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel2.add(textField2, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 2;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 10, 0);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel2.add(label4, GBC);
        
        GBC.gridx = 1;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 40;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 100, 10, 10);
        GBC.anchor = GridBagConstraints.EAST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel2.add(button2, GBC);
    }
    
    private void presetViewNominaParafiscales(){
        //STAR VALUES
        //currentView = TEXT_TITLE_LIQ_NM_PF;
        titleWindowLabel.setText(TEXT_TITLE_LIQ_NM_PF);
        
        label1.setText(TEXT_LABEL_ING_EMP);
        label1.setHorizontalAlignment(SwingConstants.LEFT);
        label1.setForeground(Color.BLACK);
        label2.setText(TEXT_LABEL_VALUE + TEXT_LABEL_VALUE_NUM);
        label2.setHorizontalAlignment(SwingConstants.LEFT);
        label2.setForeground(Color.BLACK);
        label3.setText(TEXT_LABEL_ING_EMP);
        label3.setHorizontalAlignment(SwingConstants.LEFT);
        label3.setForeground(Color.BLACK);
        label4.setText(TEXT_LABEL_VALUE + TEXT_LABEL_VALUE_NUM);
        label4.setHorizontalAlignment(SwingConstants.LEFT);
        label4.setForeground(Color.BLACK);
        
        textField1.setText(null);
        textField2.setText(null);
        
        button1.setText(TEXT_BUTTON_LIQ_NOMIN);
        button2.setText(TEXT_BUTTON_LIQ_PARAF);        
        
        //BAR PANEL
        //backWindowControlButton.hide();
        backWindowControlButton.setVisible(true);
        
        GBC.gridx = 4;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.HORIZONTAL;
        GBC.ipadx = 0;
        GBC.ipady = 0;
        GBC.insets = new Insets(10, 10, 10, 10);
        GBC.anchor = GridBagConstraints.CENTER;
        GBC.weightx = 0.6;
        GBC.weighty = 0.0;
        barPanel.add(titleWindowLabel, GBC);
        
        //CENTRAL PANEL
        centralPanel.setBackground(Color.WHITE);
        //Borrar fondo
        panel1.removeAll();
        panel1.setOpaque(false);
        panel1.setBackground(Color.WHITE);
        panel2.removeAll();
        panel2.setOpaque(false);
        panel2.setBackground(Color.WHITE);
        
        //PANEL 1 in CENTRAL PANEL
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 10, 10);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 1.0;
        GBC.weighty = 0.5;
        centralPanel.add(panel1, GBC);
        
        //PANEL 2 in CENTRAL PANEL
        GBC.gridx = 0;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.NONE;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 10, 10);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 1.0;
        GBC.weighty = 0.5;
        centralPanel.add(panel2, GBC);
        
        //LOCATE COMPONENTS
        //COMPONENTS in PANEL 1
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 3, 200);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(label1, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(5, 10, 10, 10);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(textField1, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 2;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 10, 0);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(label2, GBC);
                
        GBC.gridx = 1;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 65;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 100, 10, 10);
        GBC.anchor = GridBagConstraints.EAST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel1.add(button1, GBC);
        
        //COMPONENTS in PANEL 2
        GBC.gridx = 0;
        GBC.gridy = 0;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 3, 200);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel2.add(label3, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(5, 10, 10, 10);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel2.add(textField2, GBC);
        
        GBC.gridx = 0;
        GBC.gridy = 2;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 10;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 10, 10, 0);
        GBC.anchor = GridBagConstraints.WEST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel2.add(label4, GBC);
        
        GBC.gridx = 1;
        GBC.gridy = 1;
        GBC.gridheight = 1;
        GBC.gridwidth = 1;
        GBC.fill = GridBagConstraints.BOTH;
        GBC.ipadx = 40;
        GBC.ipady = 10;
        GBC.insets = new Insets(10, 100, 10, 10);
        GBC.anchor = GridBagConstraints.EAST;
        GBC.weightx = 0.0;
        GBC.weighty = 0.0;
        panel2.add(button2, GBC);
    }
    
    /*LISTENERS=================================================================*/
    private void initComponentListener(){
        backWindowControlButton.addActionListener(this);
        minimizeWindowControlButton.addActionListener(this);
        maximizeRestoreWindowControlButton.addActionListener(this);
        closeWindowControlButton.addActionListener(this);
        
        button1.addActionListener(this);
        button2.addActionListener(this);
        button3.addActionListener(this);
        
    }
    
    @Override
    public void actionPerformed(ActionEvent e) {
        //BAR BUTTONS===========================================================
        //BUTTON backWindowControlButton
        if(e.getSource() == backWindowControlButton){
            switch (titleWindowLabel.getText()){
                case TEXT_TITLE_LIQ_PR_SS:
                    presetViewMainWindow();
                    break;
                case TEXT_TITLE_LIQ_NM_PF:
                    presetViewMainWindow();
                    break;
                default:
                    presetViewMainWindow();
                    break;
            }
        }
        
        //BUTTON minimizeWindowControlButton
        if(e.getSource() == minimizeWindowControlButton){
            window.setExtendedState(ICONIFIED);
        }
        
        //BUTTON maximizeRestoreWindowControlButton
        if(e.getSource() == maximizeRestoreWindowControlButton){
            if(maximizeRestoreWindowControlButton.getText().equals(" [] ")){
                maximizeRestoreWindowControlButton.setText(" ]] ");
                window.setExtendedState(JFrame.MAXIMIZED_BOTH);
            }else{
                maximizeRestoreWindowControlButton.setText(" [] ");
                window.setExtendedState(JFrame.NORMAL);
                windowSize(70);
            }
        }
        
        //BUTTON closeWindowControlButton
        if(e.getSource() == closeWindowControlButton){
            window.setVisible(false);
            window.dispose();
        }
        
        //BODY BUTTONS==========================================================
        //BUTTON 1
        if(e.getSource() == button1){
            switch (titleWindowLabel.getText()){
                case TEXT_TITLE_MAIN_WINDOW:
                    //GO TO crear empleado
                    contratarEmpleado();
                    break;
                case TEXT_TITLE_LIQ_PR_SS:
                    //GO TO liquidar PRESTACIONES
                    liquidarPrestacionesSociales();
                    break;
                case TEXT_TITLE_LIQ_NM_PF:
                    //GO TO liquidar NOMINA
                    liquidarNomina();
                    break;
                default:
                    presetViewMainWindow();
            }
        }
        
        //BUTTON 2
        if(e.getSource() == button2){
            switch (titleWindowLabel.getText()){
                case TEXT_TITLE_MAIN_WINDOW:
                    //GO TO liquidar PRESTACIONES y SEGURIDAD SOCIAL
                    presetViewPrestacionesYSeguridadSocial();
                    break;
                case TEXT_TITLE_LIQ_PR_SS:
                    //GO TO liquidar SEGURIDAD SOCIAL
                    liquidarSeguridadSocial();
                    break;
                case TEXT_TITLE_LIQ_NM_PF:
                    //GO TO liquidar PARAFISCALES
                    liquidarParafiscales();
                    break;
                default:
                    presetViewMainWindow();
            }
        }
        
        //BUTTON 3
        if(e.getSource() == button3){
            switch (titleWindowLabel.getText()){
                case TEXT_TITLE_MAIN_WINDOW:
                    //GO TO liquidar NOMINA y PARAFISCALES
                    presetViewNominaParafiscales();
                    break;
                default:
                    presetViewMainWindow();
            }
        }        
        
    }
    
    /*VALIDATE INPUTS===========================================================*/
    private boolean isValidName(String name){
        boolean isValid = false;
        
        try {
            if(Pattern.matches(PATTERN_NAME, removeBlankEndsCharacters(name))){
                isValid = true;
            }else{
                JOptionPane.showMessageDialog(null, "El nombre \"" + removeBlankEndsCharacters(name) + "\" NO es valido");
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e);
        }
        
        return isValid;
    }
    
    private boolean isValidWage(String wage){
        boolean isValid = false;
        
        try {
            if(Integer.parseInt(removeBlankEndsCharacters(wage)) > 0){
                isValid = true;
            }
        } catch (NumberFormatException nfe) {
            System.out.println("Error: " + nfe);
            JOptionPane.showMessageDialog(null, "El salario \" $" + removeBlankEndsCharacters(wage) + " \" NO es valido.\nDebe ser un número entero.");
            
        } 
        
        return isValid;
    }
    
    private String removeBlankEndsCharacters(String string){
        try {            
            while( ' ' == (string.charAt(string.length()-1)) ){
                string = string.substring(0, string.length()-1);
            }
            while( ' ' == (string.charAt(0)) ){
                string = string.substring(1, string.length());
            }            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return string;
    }
    
    /*LOGICAL PROCESS===========================================================*/
    private boolean contratarEmpleado(){
        boolean isHired = false;
        Empleado empleado = null;
        boolean isValidName = false;
        
        try {
            isValidName = isValidName(textField1.getText());
            
            if(isValidName && isValidWage(textField2.getText())){
                String name = removeBlankEndsCharacters(textField1.getText().toLowerCase());
                int wage = Integer.parseInt(removeBlankEndsCharacters(textField2.getText()));
                
                empleado = new Empleado(name, wage);
                
                banco.setEmpleado(empleado);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        } finally{
            if( empleado != null ){
                isHired = true;
                textField1.setText(null);
                textField2.setText(null);
                JOptionPane.showMessageDialog(null, "¡Empleado creado con exito! \n\n" + empleado.toString());
            }else{                
                if(isValidName){
                    textField1.setText(removeBlankEndsCharacters(textField1.getText()));
                    textField2.setText(removeBlankEndsCharacters(textField2.getText()));
                    textField2.requestFocus();
                    textField2.setSelectionStart(0);
                    textField2.setSelectionEnd(textField2.getText().length());
                }else {
                    textField1.setText(removeBlankEndsCharacters(textField1.getText()));
                    textField2.setText(null);
                    textField1.requestFocus();
                    textField1.setSelectionStart(0);
                    textField1.setSelectionEnd(textField1.getText().length());                
                }
                
                JOptionPane.showMessageDialog(null, "El empleado NO fue creado");
            }
        }
        
        return isHired;
    }
    
    private boolean liquidarPrestacionesSociales(){
        boolean isDone = false;
        Empleado empleado;
        
        try {
            if(isValidName(textField1.getText())){
                empleado = banco.getEmpleado(removeBlankEndsCharacters(textField1.getText()));
                if(empleado != null){
                    value = Banco.liquidarPrestacionesEmp(empleado);
                    label2.setText(TEXT_LABEL_VALUE + String.format(CURRENCY_FORMAT, value));
                    if(label2.getText().equals(TEXT_LABEL_VALUE + String.format(CURRENCY_FORMAT, value))){
                        isDone = true;     
                    }
                }else{
                    JOptionPane.showMessageDialog(null, "El empleado \""+ removeBlankEndsCharacters(textField1.getText()) +"\" NO esta registrado.");
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        } finally{
            textField1.requestFocus();
            textField1.setText(removeBlankEndsCharacters(textField1.getText()));
            if(!isDone){ 
                label2.setText(TEXT_LABEL_VALUE + TEXT_LABEL_VALUE_NUM);
                textField1.setSelectionStart(0);
                textField1.setSelectionEnd(textField1.getText().length());            
            }
        }
        
        return isDone;
    }
    
    private boolean liquidarSeguridadSocial(){
        boolean isDone = false;
        Empleado empleado;
        
        try {
            if(isValidName(textField2.getText())){
                empleado = banco.getEmpleado(removeBlankEndsCharacters(textField2.getText()));
                if(empleado != null){
                    value = Banco.liquidarSegSocialEmp(empleado);
                    label4.setText(TEXT_LABEL_VALUE + String.format(CURRENCY_FORMAT, value));
                    if(label4.getText().equals(TEXT_LABEL_VALUE + String.format(CURRENCY_FORMAT, value))){
                        isDone = true;     
                    }
                }else{
                    JOptionPane.showMessageDialog(null, "El empleado \""+ removeBlankEndsCharacters(textField2.getText()) +"\" NO esta registrado.");
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        } finally{
            textField2.requestFocus();
            textField2.setText(removeBlankEndsCharacters(textField2.getText()));
            if(!isDone){ 
                label4.setText(TEXT_LABEL_VALUE + TEXT_LABEL_VALUE_NUM);
                textField2.setSelectionStart(0);
                textField2.setSelectionEnd(textField2.getText().length());            
            }
        }
        
        return isDone;
    }
    
    private boolean liquidarNomina(){
        boolean isDone = false;
        Empleado empleado;
        
        try {
            if(isValidName(textField1.getText())){
                empleado = banco.getEmpleado(removeBlankEndsCharacters(textField1.getText()));
                if(empleado != null){
                    value = Banco.liquidarNominaEmp(empleado);
                    label2.setText(TEXT_LABEL_VALUE + String.format(CURRENCY_FORMAT, value));
                    if(label2.getText().equals(TEXT_LABEL_VALUE + String.format(CURRENCY_FORMAT, value))){
                        isDone = true;     
                    }
                }else{
                    JOptionPane.showMessageDialog(null, "El empleado \""+ removeBlankEndsCharacters(textField1.getText()) +"\" NO esta registrado.");
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        } finally{
            textField1.requestFocus();
            textField1.setText(removeBlankEndsCharacters(textField1.getText()));
            if(!isDone){ 
                label2.setText(TEXT_LABEL_VALUE + TEXT_LABEL_VALUE_NUM);
                textField1.setSelectionStart(0);
                textField1.setSelectionEnd(textField1.getText().length());            
            }
        }
        
        return isDone;
    }
    
    private boolean liquidarParafiscales(){
        boolean isDone = false;
        Empleado empleado;
        
        try {
            if(isValidName(textField2.getText())){
                empleado = banco.getEmpleado(removeBlankEndsCharacters(textField2.getText()));
                if(empleado != null){
                    value = Banco.liquidarParafiscalesEmp(empleado);
                    label4.setText(TEXT_LABEL_VALUE + String.format(CURRENCY_FORMAT, value));
                    if(label4.getText().equals(TEXT_LABEL_VALUE + String.format(CURRENCY_FORMAT, value))){
                        isDone = true;     
                    }
                }else{
                    JOptionPane.showMessageDialog(null, "El empleado \""+ removeBlankEndsCharacters(textField2.getText()) +"\" NO esta registrado.");
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        } finally{
            textField2.requestFocus();
            textField2.setText(removeBlankEndsCharacters(textField2.getText()));
            if(!isDone){ 
                label4.setText(TEXT_LABEL_VALUE + TEXT_LABEL_VALUE_NUM);
                textField2.setSelectionStart(0);
                textField2.setSelectionEnd(textField2.getText().length());            
            }
        }
        
        return isDone;
    }

}
