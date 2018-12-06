/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package enmaf;

/**
 *
 * @author missa
 */
public class Errores {
  public Integer Linea;
  public Integer Columna;
  public String Descripcion;
  public Errores(Integer Linea, Integer Columna, String Descripcion) {
    this.Linea = Linea;
    this.Columna = Columna;
    this.Descripcion = Descripcion;
  }
    
}
