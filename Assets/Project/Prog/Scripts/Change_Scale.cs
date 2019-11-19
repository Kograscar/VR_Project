using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Change_Scale : MonoBehaviour {

    [SerializeField] private GameObject _Zonetoscale = null;
    [SerializeField] private GameObject _Puzzletoscale = null;
    [SerializeField] private GameObject _VFX_Inter_6 = null;
    [SerializeField] private GameObject _VFX_Inter_8 = null;
    [SerializeField] private GameObject _VFX_Exter = null;
    [SerializeField] private float _ScaleValue = 0f;

    private void Start()
    {
        _ScaleValue = 1;
        _VFX_Inter_6.SetActive(false);
        _VFX_Inter_8.SetActive(false);
        _VFX_Exter.SetActive(true);
    }

    void Update ()
    {
        _Zonetoscale.transform.localScale = new Vector3(_ScaleValue, 1, _ScaleValue);
        _Puzzletoscale.transform.localScale = new Vector3(_ScaleValue, _ScaleValue, _ScaleValue);
     
        if(_ScaleValue == 2)
        {
            _VFX_Exter.SetActive(false);
            _VFX_Inter_8.SetActive(true);
        }
        if(_ScaleValue == 1)
        {
            _VFX_Exter.SetActive(true);
            _VFX_Inter_8.SetActive(false);
        }
    }
    private void OnTriggerEnter(Collider other)
    {
        Debug.Log("Triggertest ok");
        if (other.name == "[VRTK][AUTOGEN][BodyColliderContainer]")
        {
        Debug.Log("Triggertest le player");
            _ScaleValue = 2;
        }
    }
    private void OnTriggerExit(Collider other)
    {
        if (other.name == "[VRTK][AUTOGEN][BodyColliderContainer]")
        {
            _ScaleValue = 1;
        }
    }

}
