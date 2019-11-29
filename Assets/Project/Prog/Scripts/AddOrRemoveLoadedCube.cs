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

    bool _min;
    bool _max;

    float _delay;

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
    }

    private void Update()
    {
        _text.text = _cubeLoader._colors[_color].ToString();

        _delay += Time.deltaTime;

        if (_delay > 0.5f)
        {
            if (_min)
            {
                if (0 < _cubeLoader._actualCube && _cubeLoader._colors[_color] > 0)
                {
                    _cubeLoader._colors[_color]--;
                    _cubeLoader._actualCube--;
                }
                _delay = 0;
            }
            else if (_max)
            {
                if (_cubeLoader._maxCube > _cubeLoader._actualCube)
                {
                    _cubeLoader._colors[_color]++;
                    _cubeLoader._actualCube++;
                }
                _delay = 0;
            }
        }
    }

    IEnumerator LateStart()
    {
        yield return new WaitForEndOfFrame();

        _slider.SetValue(20);

        _slider.ValueChanged += (object sender, ControllableEventArgs e) =>
        {
            if (_slider.GetValue() > 35)
            {
                if (!_max)
                {
                    if(_cubeLoader._maxCube > _cubeLoader._actualCube)
                    {
                        _cubeLoader._colors[_color]++;
                        _cubeLoader._actualCube++;
                    }
                    _max = true;
                    _delay = 0;
                }
            }
            else if (_slider.GetValue() < 5)
            {
                if (!_min)
                {
                    if (0 < _cubeLoader._actualCube && _cubeLoader._colors[_color] > 0)
                    {
                        _cubeLoader._colors[_color]--;
                        _cubeLoader._actualCube--;
                    }
                    _min = true;
                    _delay = 0;
                }
            }
            else
            {
                _min = false;
                _max = false;
            }
        };
    }
}
