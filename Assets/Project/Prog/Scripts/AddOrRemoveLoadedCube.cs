using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;
using TMPro;

public class AddOrRemoveLoadedCube : MonoBehaviour {

    [SerializeField] VRTK_ArtificialPusher _lessPusher;
    [SerializeField] VRTK_ArtificialPusher _morePusher;

    [SerializeField] CubeLoader _cubeLoader;

    [SerializeField] TextMeshProUGUI _text;

    int _color;

    private void Start()
    {
        switch (tag)
        {
            case "Green":
                _color = 0;

                break;

            case "Red":
                _color = 1;

                break;

            case "Yellow":
                _color = 2;

                break;

            case "Blue":
                _color = 3;

                break;

            case "Purple":
                _color = 4;

                break;

            case "White":
                _color = 5;

                break;
        }

        _morePusher.MinLimitExited += (object sender, ControllableEventArgs e) =>
        {
            if(_cubeLoader._actualCube < _cubeLoader._maxCube)
            {
                _cubeLoader._colors[_color]++;
                _cubeLoader._actualCube++;
            }
        };

        _lessPusher.MinLimitExited += (object sender, ControllableEventArgs e) =>
        {
            if(_cubeLoader._actualCube > 0)
            {
                if(_cubeLoader._colors[_color] > 0)
                {
                    _cubeLoader._colors[_color]--;
                    _cubeLoader._actualCube--;
                }
            }
        };

    }

    private void Update()
    {
        _text.text = _cubeLoader._colors[_color].ToString();
    }
}
