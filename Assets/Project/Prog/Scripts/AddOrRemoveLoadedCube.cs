using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;
using TMPro;

public class AddOrRemoveLoadedCube : MonoBehaviour {
    
    VRTK_ArtificialSlider _slider;

    [SerializeField] CubeLoader _cubeLoader;

    [SerializeField] TextMeshProUGUI _text;

    int _color;

    private void Start()
    {
        _slider = GetComponentInChildren<VRTK_ArtificialSlider>();

        StartCoroutine(LateStart());

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
        
        _slider.ValueChanged += (object sender, ControllableEventArgs e) =>
        {
            if (_slider.AtMaxLimit())
            {
                _cubeLoader._colors[_color]++;
                _cubeLoader._actualCube++;
            }
            else if (_slider.AtMinLimit())
            {
                _cubeLoader._colors[_color]--;
                _cubeLoader._actualCube--;
            }
        };
    }

    private void Update()
    {
        _text.text = _cubeLoader._colors[_color].ToString();
    }

    IEnumerator LateStart()
    {
        yield return new WaitForEndOfFrame();

        _slider.SetValue(20);
    }
}
