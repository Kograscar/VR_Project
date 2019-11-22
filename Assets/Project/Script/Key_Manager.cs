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


   // Rigidbody _rigidbody;

    private void Start()
    {
        keyOfRoom = Instantiate(_keyToInstantiate, _offset.position, _offset.rotation,_offset);
      
    }

    void Update ()
    {
        
        if (keyOfRoom == null  && _coroutineOn == false && 
           (_ZoneScale.transform.localScale == new Vector3(2,1,2) || _ZoneScale.transform.localScale == new Vector3(1.5f, 1, 1.5f)))
        {
            StartCoroutine(WaitforInstantiateKey());
        }
        else
        {
            StopCoroutine(WaitforInstantiateKey());
        }
        if(keyOfRoom != null)
        {
            if (keyOfRoom.transform.position != _offset.position)
            {
                if (_coroutine2On == false)
                {
                    StartCoroutine(WaitforDesable());
                }
            }
            else
            {
                StopCoroutine(WaitforDesable());
            }
        }
		
	}
    private IEnumerator WaitforInstantiateKey()
    {
        _coroutineOn = true;
        yield return new WaitForSeconds(1f);
        keyOfRoom = Instantiate(_keyToInstantiate, _offset.position, _offset.rotation, _offset);
        //keyOfRoom.transform.position = _offset.position;
        //keyOfRoom.SetActive(true);
        _coroutineOn = false;
    }

    private IEnumerator WaitforDesable()
    {
        _coroutine2On = true;
        yield return new WaitForSeconds(5f);
        Destroy(keyOfRoom);
        //keyOfRoom.SetActive(false);
        //_rigidbody.velocity = new Vector3();
        _coroutine2On = false;
    }

}
