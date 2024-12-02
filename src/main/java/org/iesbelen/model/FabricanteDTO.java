package org.iesbelen.model;

public class FabricanteDTO extends Fabricante {

    private int idFabricante;
    private String nombre;
    private int numProductos;

    public FabricanteDTO() {

    }

    public FabricanteDTO(Fabricante fab, int numProductos) {
        setIdFabricante(fab.getIdFabricante());
        setNombre(fab.getNombre());
        this.numProductos = numProductos;
    }

    public FabricanteDTO(int idFabricante, String nombre, int numProductos) {
        setIdFabricante(idFabricante);
        setNombre(nombre);
        this.numProductos = numProductos;
    }

    public void setNumProductos(int numProductos) {
        this.numProductos = numProductos;
    }

    public int getNumProductos() {
        return numProductos;
    }

}
