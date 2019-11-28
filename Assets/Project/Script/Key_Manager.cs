using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Key_Manager : MonoBehaviour {

    [SerializeField] private GameObject _keyToInstantiate = null;
    [SerializeField] private Transform _offset = null;
    [SerializeField] private GameObject keyOfRoom = null;
    [SerializeField] private bool _coroutineOn = false;
    [SerializeField] private bool _coroutine2On = false;
    [SerializeField] private GameObject _ZoneScale = null;
    [SerializeField] private Collider _TriggerEnd;
    //[SerializeField] private GameObject _ZoneToDestroyAtEnd = null;


    void Update ()
    {
        
        if (keyOfRoom == null  && _coroutineOn == false && _TriggerEnd != null && _ZoneScale != null)
        {
            if(_ZoneScale.transform.localScale == new Vector3(2,1,2) || _ZoneScale.transform.localScale == new Vector3(1.5f, 1, 1.5f))
            {
                StartCoroutine(WaitforInstantiateKey());
            }
            else
            {
                StopCoroutine(WaitforInstantiateKey());
            }
        }


        if(_ZoneScale != null)
        {
		    if(_ZoneScale.transform.localScale == new Vector3(1, 1, 1) && keyOfRoom != null)
            {
                Destroy(keyOfRoom);
            }

        }

      

        //A virer
        //if(keyOfRoom != null)
        //{
            //if (keyOfRoom.transform.position != _offset.position)
            //{
            //    if (_coroutine2On == false)
            //    {
            //        StartCoroutine(WaitforDesable());
            //    }
            //}
            //else
            //{
            //    StopCoroutine(WaitforDesable());
            //}
        //}



	}
    private IEnumerator WaitforInstantiateKey()
    {
        _coroutineOn = true;
        yield return new WaitForSeconds(1f);
        keyOfRoom = Instantiate(_keyToInstantiate, _offset.position, _offset.rotation, _offset);
    
        _coroutineOn = false;
    }

    //private IEnumerator WaitforDesable()
    //{
    //    _coroutine2On = true;
    //    yield return new WaitForSeconds(10f);
    //    Destroy(keyOfRoom);
    //    _coroutine2On = false;
    //}

}
