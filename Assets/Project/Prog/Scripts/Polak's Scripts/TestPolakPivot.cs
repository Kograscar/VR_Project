using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestPolakPivot : MonoBehaviour
{

    public Animator AnimPivot;
    [SerializeField] private Vector3 _position;

    private bool _hasBeenUsed = false;

    Rigidbody _rig;

    ChuiLeCube _chui;

    GameObject _go;

    private bool _animationpivotOn = false;

    private void Start()
    {
        _animationpivotOn = true;
    }
    private void LateUpdate()

    {
        if (_hasBeenUsed)
        {
            if (_chui._detect)
            {
                _go.transform.parent = null;
                Debug.Log("fini");
                StopAllCoroutines();
                StartCoroutine(BackAnim());
            }
        }
    }

    private void OnTriggerEnter(Collider collision)
    {
        
        if (_hasBeenUsed == false && collision.gameObject.tag == "MainCube")
        {
            _hasBeenUsed = true;
            Debug.Log("slt lé pote");

            _rig = collision.transform.GetComponent<Rigidbody>();
            _rig.velocity = new Vector3();

            _chui = collision.GetComponent<ChuiLeCube>();

            _go = collision.gameObject;

            collision.transform.parent = transform;
            collision.transform.localPosition = _position;

            if(_animationpivotOn == true)
            {
            StartCoroutine(DelayPivot(collision.transform));

            }

        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.tag == "MainCube")
        {
          //  other.transform.parent = null;
            Debug.Log("fini");
            _hasBeenUsed = false;
            StartCoroutine(BackAnim());
        }
    }
    

    IEnumerator DelayPivot(Transform collider)
    {
       
        yield return new WaitForSeconds(0.3f);
        
        AnimPivot.SetTrigger("Pivot");
        _animationpivotOn = false;
        /*yield return*/ StartCoroutine(StopParent(collider.transform));
    }

   IEnumerator StopParent(Transform collider)
    {
        yield return new WaitForSeconds(1);
        if(_animationpivotOn == false)
        {

        collider.parent = null;
        Debug.Log("fini");
        StartCoroutine(BackAnim());
        _hasBeenUsed = false;
        }
        else
        {
            yield return null;
        }

    }

    IEnumerator BackAnim()
    {

        yield return new WaitForSeconds(0.99F);
        if (_animationpivotOn == false)
        {

            AnimPivot.SetTrigger("backAnim");
            StopAllCoroutines();
            _hasBeenUsed = false;
            _animationpivotOn = true;
        }
    }
    void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireCube(transform.position + _position, Vector3.one * 0.25f);
    }
}
