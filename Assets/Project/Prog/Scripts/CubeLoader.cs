using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;
using TMPro;

public class CubeLoader : MonoBehaviour {

    public int _maxCube;
    public int _actualCube;


    public int[] _colors = new int[6];


    [SerializeField] TextMeshProUGUI _maxCubeText;


    VRTK_ArtificialPusher vrtk_ArtificialPusher;

    [SerializeField] GameObject _fx;
    [SerializeField] Transform _offsetFX;


    void Start()
    {
        /*vrtk_ArtificialPusher = GetComponent<VRTK_ArtificialPusher>();
        vrtk_ArtificialPusher.MinLimitExited += (object sender, ControllableEventArgs e) => 
        {
            CubeInstanciater.Instance.LoadCube(_colors[0], _colors[1], _colors[2], _colors[3], _colors[4], _colors[5]);
        };*/
    }

    private void Update()
    {
        _maxCubeText.text = _actualCube.ToString() + " / " + _maxCube.ToString();
    }

    private void OnTriggerEnter(Collider other)
    {        
        if (other.GetComponentInParent<VRTK_ControllerEvents>().gameObject.CompareTag("Controller"))
        {
            CubeInstanciater.Instance.LoadCube(_colors[0], _colors[1], _colors[2], _colors[3], _colors[4], _colors[5]);
            Destroy(Instantiate(_fx, _offsetFX.transform.position, _offsetFX.transform.rotation), 3f);
        }
    }
}
