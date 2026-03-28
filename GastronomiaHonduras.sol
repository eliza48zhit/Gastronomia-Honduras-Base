// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaHonduras
 * @dev Registro historico con Likes, Dislikes e Identificador de Tortilla (Harina/Maiz).
 */
contract GastronomiaHonduras {

    struct Plato {
        string nombre;
        string descripcion;
        string tipoTortilla; // Ej: Harina de Trigo, Maiz Blanco, Maiz Amarillo
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con la Baleada Especial
        registrarPlato(
            "Baleada Especial", 
            "Tortilla de harina doblada, rellena de frijoles refritos, mantequilla, queso, huevo y aguacate.",
            "Harina de Trigo"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _tipoTortilla
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            tipoTortilla: _tipoTortilla,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory tipoTortilla,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.tipoTortilla, p.likes, p.dislikes);
    }
}
